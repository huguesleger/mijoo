import { readFileSync } from 'node:fs';
import { after, before, beforeEach, describe, test } from 'node:test';
import { assertFails, assertSucceeds, initializeTestEnvironment } from '@firebase/rules-unit-testing';
import {
  Timestamp,
  arrayRemove,
  arrayUnion,
  collection,
  doc,
  getDoc,
  getDocs,
  serverTimestamp,
  setDoc,
  writeBatch,
} from 'firebase/firestore';

let env;

before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-mijoo-invites',
    firestore: { rules: readFileSync('../firestore.rules', 'utf8') },
  });
});

after(() => env.cleanup());

beforeEach(() => env.clearFirestore());

const db = (uid) => (uid ? env.authenticatedContext(uid).firestore() : env.unauthenticatedContext().firestore());
const inHours = (hours) => Timestamp.fromMillis(Date.now() + hours * 3600 * 1000);

async function createHousehold(uid) {
  const firestore = db(uid);
  const household = doc(collection(firestore, 'households'));
  const batch = writeBatch(firestore);
  batch.set(household, { memberIds: [uid], createdBy: uid, createdAt: serverTimestamp(), profile: null });
  batch.set(doc(firestore, 'users', uid), { householdId: household.id });
  await batch.commit();
  return household.id;
}

const invite = (householdId, overrides = {}) => ({
  householdId,
  createdBy: 'hugues',
  createdAt: serverTimestamp(),
  expiresAt: inHours(48),
  usedBy: null,
  ...overrides,
});

async function seedInvite(code, data) {
  await env.withSecurityRulesDisabled((context) => setDoc(doc(context.firestore(), 'invites', code), data));
}

function join(uid, householdId, code) {
  const firestore = db(uid);
  return writeBatch(firestore)
    .update(doc(firestore, 'households', householdId), { memberIds: arrayUnion(uid), lastInvite: code })
    .update(doc(firestore, 'invites', code), { usedBy: uid })
    .set(doc(firestore, 'users', uid), { householdId })
    .set(doc(firestore, 'households', householdId, 'members', uid), { name: 'Camille' })
    .commit();
}

describe('codes d’invitation', () => {
  test('un membre crée un code de 48 heures pour son foyer', async () => {
    const householdId = await createHousehold('hugues');
    await assertSucceeds(setDoc(doc(db('hugues'), 'invites', 'MJ4K7Q'), invite(householdId)));
  });

  test('on ne crée pas de code pour un autre foyer ni trop long', async () => {
    const householdId = await createHousehold('hugues');
    await assertFails(setDoc(doc(db('alex'), 'invites', 'ABCDEF'), invite(householdId, { createdBy: 'alex' })));
    await assertFails(setDoc(doc(db('hugues'), 'invites', 'ABCDEF'), invite(householdId, { expiresAt: inHours(24 * 30) })));
    await assertFails(setDoc(doc(db('hugues'), 'invites', 'ABCDEF'), invite(householdId, { usedBy: 'hugues' })));
  });

  test('un code se lit à l’unité mais ne se liste pas', async () => {
    const householdId = await createHousehold('hugues');
    await seedInvite('MJ4K7Q', invite(householdId));
    await assertSucceeds(getDoc(doc(db('camille'), 'invites', 'MJ4K7Q')));
    await assertFails(getDocs(collection(db('camille'), 'invites')));
    await assertFails(getDoc(doc(db(), 'invites', 'MJ4K7Q')));
  });
});

describe('rejoindre un foyer', () => {
  test('avec un code valide, on rejoint le foyer et on en voit tout', async () => {
    const householdId = await createHousehold('hugues');
    await seedInvite('MJ4K7Q', invite(householdId));
    await assertSucceeds(join('camille', householdId, 'MJ4K7Q'));
    await assertSucceeds(getDoc(doc(db('camille'), 'households', householdId)));
    await assertSucceeds(getDocs(collection(db('camille'), 'households', householdId, 'members')));
  });

  test('un code expiré ou déjà utilisé est refusé', async () => {
    const householdId = await createHousehold('hugues');
    await seedInvite('EXPIRE', invite(householdId, { expiresAt: inHours(-1) }));
    await seedInvite('UTILIS', invite(householdId, { usedBy: 'alex' }));
    await assertFails(join('camille', householdId, 'EXPIRE'));
    await assertFails(join('camille', householdId, 'UTILIS'));
  });

  test('un code d’un autre foyer ne fait pas entrer dans celui-ci', async () => {
    const householdId = await createHousehold('hugues');
    const otherId = await createHousehold('alex');
    await seedInvite('AUTRE2', invite(otherId, { createdBy: 'alex' }));
    await assertFails(join('camille', householdId, 'AUTRE2'));
  });

  test('sans code, on ne s’ajoute pas et on n’ajoute personne', async () => {
    const householdId = await createHousehold('hugues');
    const firestore = db('camille');
    await assertFails(
      writeBatch(firestore)
        .update(doc(firestore, 'households', householdId), { memberIds: arrayUnion('camille') })
        .set(doc(firestore, 'users', 'camille'), { householdId })
        .commit(),
    );
    await seedInvite('MJ4K7Q', invite(householdId));
    const other = db('camille');
    await assertFails(
      writeBatch(other)
        .update(doc(other, 'households', householdId), { memberIds: arrayUnion('alex'), lastInvite: 'MJ4K7Q' })
        .update(doc(other, 'invites', 'MJ4K7Q'), { usedBy: 'alex' })
        .commit(),
    );
  });
});

describe('quitter un foyer', () => {
  test('un membre se retire et efface son lien', async () => {
    const householdId = await createHousehold('hugues');
    await seedInvite('MJ4K7Q', invite(householdId));
    await join('camille', householdId, 'MJ4K7Q');
    const firestore = db('camille');
    await assertSucceeds(
      writeBatch(firestore)
        .update(doc(firestore, 'households', householdId), { memberIds: arrayRemove('camille') })
        .delete(doc(firestore, 'households', householdId, 'members', 'camille'))
        .delete(doc(firestore, 'users', 'camille'))
        .commit(),
    );
    await assertFails(getDoc(doc(db('camille'), 'households', householdId)));
  });

  test('on ne retire pas un autre membre', async () => {
    const householdId = await createHousehold('hugues');
    await seedInvite('MJ4K7Q', invite(householdId));
    await join('camille', householdId, 'MJ4K7Q');
    const firestore = db('camille');
    await assertFails(
      writeBatch(firestore).update(doc(firestore, 'households', householdId), { memberIds: arrayRemove('hugues') }).commit(),
    );
  });
});
