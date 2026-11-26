import { readFileSync } from 'node:fs';
import { after, before, beforeEach, describe, test } from 'node:test';
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from '@firebase/rules-unit-testing';
import {
  collection,
  doc,
  getDoc,
  serverTimestamp,
  setDoc,
  updateDoc,
  deleteDoc,
  writeBatch,
} from 'firebase/firestore';

const profile = {
  adults: 2,
  children: 2,
  likes: ['pâtes'],
  exclusions: ['porc'],
  allergies: ['arachide'],
  maxPrepMinutes: 30,
  weeklyBudgetCents: 12000,
  location: { postalCode: '69001', city: 'Lyon' },
};

let env;

before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-mijoo',
    firestore: { rules: readFileSync('../firestore.rules', 'utf8') },
  });
});

after(() => env.cleanup());

beforeEach(() => env.clearFirestore());

const db = (uid) =>
  uid ? env.authenticatedContext(uid).firestore() : env.unauthenticatedContext().firestore();

async function createHousehold(uid) {
  const firestore = db(uid);
  const household = doc(collection(firestore, 'households'));
  const batch = writeBatch(firestore);
  batch.set(household, {
    memberIds: [uid],
    createdBy: uid,
    createdAt: serverTimestamp(),
    profile: null,
  });
  batch.set(doc(firestore, 'users', uid), { householdId: household.id });
  await batch.commit();
  return household.id;
}

describe('création du foyer', () => {
  test('un parent crée son foyer et son lien en une seule écriture', async () => {
    await assertSucceeds(createHousehold('camille'));
  });

  test('un visiteur non connecté ne peut rien créer', async () => {
    await assertFails(
      setDoc(doc(db(), 'households', 'h1'), {
        memberIds: ['camille'],
        createdBy: 'camille',
        createdAt: serverTimestamp(),
        profile: null,
      }),
    );
  });

  test('on ne peut pas créer un foyer au nom de quelqu’un d’autre', async () => {
    await assertFails(
      setDoc(doc(db('camille'), 'households', 'h1'), {
        memberIds: ['alex'],
        createdBy: 'alex',
        createdAt: serverTimestamp(),
        profile: null,
      }),
    );
  });

  test('on ne peut pas ajouter d’autres membres à la création', async () => {
    await assertFails(
      setDoc(doc(db('camille'), 'households', 'h1'), {
        memberIds: ['camille', 'alex'],
        createdBy: 'camille',
        createdAt: serverTimestamp(),
        profile: null,
      }),
    );
  });

  test('on ne peut pas se rattacher au foyer d’un autre parent', async () => {
    const householdId = await createHousehold('alex');
    await assertFails(
      setDoc(doc(db('camille'), 'users', 'camille'), { householdId }),
    );
  });
});

describe('isolation entre foyers', () => {
  test('un membre lit son foyer et son lien', async () => {
    const householdId = await createHousehold('camille');
    await assertSucceeds(getDoc(doc(db('camille'), 'households', householdId)));
    await assertSucceeds(getDoc(doc(db('camille'), 'users', 'camille')));
  });

  test('un autre parent ne lit ni le foyer ni le lien', async () => {
    const householdId = await createHousehold('camille');
    await assertFails(getDoc(doc(db('alex'), 'households', householdId)));
    await assertFails(getDoc(doc(db('alex'), 'users', 'camille')));
  });

  test('les sous-collections restent réservées aux membres', async () => {
    const householdId = await createHousehold('camille');
    const item = (uid) => doc(db(uid), 'households', householdId, 'stock', 'tomates');
    await assertSucceeds(setDoc(item('camille'), { name: 'Tomates' }));
    await assertFails(getDoc(item('alex')));
    await assertFails(setDoc(item('alex'), { name: 'Tomates' }));
  });
});

describe('profil du foyer', () => {
  test('un membre enregistre un profil valide', async () => {
    const householdId = await createHousehold('camille');
    await assertSucceeds(
      updateDoc(doc(db('camille'), 'households', householdId), { profile }),
    );
  });

  test('un profil sans budget ni localisation reste valide', async () => {
    const householdId = await createHousehold('camille');
    await assertSucceeds(
      updateDoc(doc(db('camille'), 'households', householdId), {
        profile: { ...profile, weeklyBudgetCents: null, location: null },
      }),
    );
  });

  test('un profil incohérent est refusé', async () => {
    const householdId = await createHousehold('camille');
    const ref = doc(db('camille'), 'households', householdId);
    await assertFails(updateDoc(ref, { profile: { ...profile, adults: 0 } }));
    await assertFails(updateDoc(ref, { profile: { ...profile, pets: 2 } }));
    await assertFails(updateDoc(ref, { profile: { ...profile, maxPrepMinutes: '30' } }));
  });

  test('un membre ne peut pas modifier la liste des membres', async () => {
    const householdId = await createHousehold('camille');
    await assertFails(
      updateDoc(doc(db('camille'), 'households', householdId), {
        memberIds: ['camille', 'alex'],
      }),
    );
  });

  test('un autre parent ne peut pas modifier le profil', async () => {
    const householdId = await createHousehold('camille');
    await assertFails(
      updateDoc(doc(db('alex'), 'households', householdId), { profile }),
    );
  });

  test('personne ne supprime un foyer ou son lien depuis l’app', async () => {
    const householdId = await createHousehold('camille');
    await assertFails(deleteDoc(doc(db('camille'), 'households', householdId)));
    await assertFails(deleteDoc(doc(db('camille'), 'users', 'camille')));
  });
});
