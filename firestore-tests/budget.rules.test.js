import { readFileSync } from 'node:fs';
import { after, before, beforeEach, describe, test } from 'node:test';
import { assertFails, assertSucceeds, initializeTestEnvironment } from '@firebase/rules-unit-testing';
import {
  Timestamp,
  addDoc,
  collection,
  deleteDoc,
  doc,
  getDocs,
  query,
  serverTimestamp,
  setDoc,
  updateDoc,
  where,
  writeBatch,
} from 'firebase/firestore';

let env;

before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-mijoo-budget',
    firestore: { rules: readFileSync('../firestore.rules', 'utf8') },
  });
});

after(() => env.cleanup());

beforeEach(() => env.clearFirestore());

const db = (uid) => (uid ? env.authenticatedContext(uid).firestore() : env.unauthenticatedContext().firestore());

async function createHousehold(uid) {
  const firestore = db(uid);
  const household = doc(collection(firestore, 'households'));
  const batch = writeBatch(firestore);
  batch.set(household, { memberIds: [uid], createdBy: uid, createdAt: serverTimestamp(), profile: null });
  batch.set(doc(firestore, 'users', uid), { householdId: household.id });
  await batch.commit();
  return household.id;
}

const price = (overrides = {}) => ({
  key: 'carotte',
  name: 'Carottes',
  cents: 115,
  basis: 'kilogram',
  updatedAt: serverTimestamp(),
  ...overrides,
});

const expense = (overrides = {}) => ({
  amountCents: 3870,
  date: Timestamp.now(),
  store: 'Lidl',
  addedBy: 'Hugues',
  createdAt: serverTimestamp(),
  ...overrides,
});

describe('prix du foyer', () => {
  test('un membre fixe et corrige le prix d’un ingrédient', async () => {
    const householdId = await createHousehold('hugues');
    const ref = doc(db('hugues'), 'households', householdId, 'prices', 'price-carotte');
    await assertSucceeds(setDoc(ref, price()));
    await assertSucceeds(setDoc(ref, price({ cents: 99.5 })));
    await assertSucceeds(getDocs(collection(db('hugues'), 'households', householdId, 'prices')));
  });

  test('un prix incohérent ou d’un autre foyer est refusé', async () => {
    const householdId = await createHousehold('hugues');
    const ref = (uid) => doc(db(uid), 'households', householdId, 'prices', 'price-carotte');
    await assertFails(setDoc(ref('hugues'), price({ cents: 0 })));
    await assertFails(setDoc(ref('hugues'), price({ basis: 'tonne' })));
    await assertFails(setDoc(ref('hugues'), price({ source: 'x' })));
    await assertFails(setDoc(ref('alex'), price()));
    await assertFails(getDocs(collection(db('alex'), 'households', householdId, 'prices')));
  });
});

describe('dépenses', () => {
  test('un membre saisit, lit et supprime une dépense', async () => {
    const householdId = await createHousehold('hugues');
    const expenses = collection(db('hugues'), 'households', householdId, 'expenses');
    const ref = await assertSucceeds(addDoc(expenses, expense()));
    await assertSucceeds(addDoc(expenses, expense({ store: null, addedBy: null })));
    await assertSucceeds(getDocs(query(expenses, where('date', '>=', Timestamp.fromMillis(0)))));
    await assertFails(updateDoc(ref, { amountCents: 1 }));
    await assertSucceeds(deleteDoc(ref));
  });

  test('une dépense incohérente ou d’un autre foyer est refusée', async () => {
    const householdId = await createHousehold('hugues');
    const expenses = (uid) => collection(db(uid), 'households', householdId, 'expenses');
    await assertFails(addDoc(expenses('hugues'), expense({ amountCents: 0 })));
    await assertFails(addDoc(expenses('hugues'), expense({ amountCents: 12.5 })));
    await assertFails(addDoc(expenses('hugues'), expense({ date: '2026-11-27' })));
    await assertFails(addDoc(expenses('hugues'), expense({ note: 'x' })));
    await assertFails(addDoc(expenses('alex'), expense()));
    await assertFails(getDocs(expenses('alex')));
  });
});
