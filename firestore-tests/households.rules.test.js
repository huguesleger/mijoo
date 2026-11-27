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

const stockItem = (overrides = {}) => ({
  name: 'Tomates',
  quantity: 4,
  unit: 'piece',
  category: 'fruitsVegetables',
  bestBefore: null,
  createdAt: serverTimestamp(),
  updatedAt: serverTimestamp(),
  ...overrides,
});

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

  test('le stock reste réservé aux membres', async () => {
    const householdId = await createHousehold('camille');
    const item = (uid) => doc(db(uid), 'households', householdId, 'stock', 'tomates');
    await assertSucceeds(setDoc(item('camille'), stockItem()));
    await assertFails(getDoc(item('alex')));
    await assertFails(setDoc(item('alex'), stockItem()));
    await assertFails(deleteDoc(item('alex')));
  });

  test('un foyer pas encore créé se lit sans rien révéler', async () => {
    await assertSucceeds(getDoc(doc(db('camille'), 'households', 'pas-encore-cree')));
    await assertFails(getDoc(doc(db(), 'households', 'pas-encore-cree')));
  });

  test('les autres sous-collections restent fermées', async () => {
    const householdId = await createHousehold('camille');
    await assertFails(
      setDoc(doc(db('camille'), 'households', householdId, 'divers', 'x'), { name: 'x' }),
    );
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

describe('stock du frigo', () => {
  test('un membre ajoute, modifie et supprime un ingrédient', async () => {
    const householdId = await createHousehold('camille');
    const ref = doc(db('camille'), 'households', householdId, 'stock', 'lait');
    await assertSucceeds(setDoc(ref, stockItem({ name: 'Lait', unit: 'liter', category: 'dairy' })));
    await assertSucceeds(updateDoc(ref, { quantity: 1.5, updatedAt: serverTimestamp() }));
    await assertSucceeds(deleteDoc(ref));
  });

  test('un ingrédient incohérent est refusé', async () => {
    const householdId = await createHousehold('camille');
    const ref = doc(db('camille'), 'households', householdId, 'stock', 'x');
    await assertFails(setDoc(ref, stockItem({ name: '' })));
    await assertFails(setDoc(ref, stockItem({ quantity: 0 })));
    await assertFails(setDoc(ref, stockItem({ unit: 'tonne' })));
    await assertFails(setDoc(ref, stockItem({ category: 'jardin' })));
    await assertFails(setDoc(ref, stockItem({ price: 3 })));
  });

  test('la date de création ne change pas', async () => {
    const householdId = await createHousehold('camille');
    const ref = doc(db('camille'), 'households', householdId, 'stock', 'oeufs');
    await assertSucceeds(setDoc(ref, stockItem({ name: 'Œufs' })));
    await assertFails(updateDoc(ref, { createdAt: new Date(0), updatedAt: serverTimestamp() }));
  });
});
