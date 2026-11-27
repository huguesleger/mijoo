import { readFileSync } from 'node:fs';
import { after, before, beforeEach, describe, test } from 'node:test';
import { assertFails, assertSucceeds, initializeTestEnvironment } from '@firebase/rules-unit-testing';
import { collection, deleteDoc, doc, getDoc, serverTimestamp, setDoc, updateDoc, writeBatch } from 'firebase/firestore';

const idea = {
  id: 'omelette',
  title: 'Omelette aux épinards',
  description: 'Une omelette fondante.',
  prepMinutes: 5,
  cookMinutes: 10,
  servings: 4,
  kind: 'pan',
  difficulty: 'easy',
  equipment: ['Poêle'],
  photo: null,
  ingredients: Array.from({ length: 12 }, (_, index) => ({
    name: `Ingrédient ${index}`,
    quantity: 2,
    unit: 'piece',
    category: 'dairy',
    substitute: null,
  })),
  steps: [{ text: 'Bats les œufs.', minutes: null }],
};

const weekMeal = (overrides = {}) => ({ idea, status: 'planned', addedAt: serverTimestamp(), ...overrides });

const entry = (overrides = {}) => ({
  key: 'oeuf',
  name: 'Œufs',
  quantity: null,
  unit: 'piece',
  category: null,
  checked: true,
  dismissed: false,
  manual: false,
  addedBy: null,
  updatedAt: serverTimestamp(),
  ...overrides,
});

let env;

before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-mijoo-shopping',
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

describe('repas de la semaine', () => {
  test('un membre prévoit, cuisine puis retire un repas', async () => {
    const householdId = await createHousehold('camille');
    const ref = doc(db('camille'), 'households', householdId, 'weekMeals', 'omelette');
    await assertSucceeds(setDoc(ref, weekMeal()));
    await assertSucceeds(setDoc(ref, weekMeal({ idea: { ...idea, servings: 6 } })));
    await assertSucceeds(updateDoc(ref, { status: 'cooked' }));
    await assertSucceeds(getDoc(ref));
    await assertSucceeds(deleteDoc(ref));
  });

  test('la semaine reste réservée au foyer', async () => {
    const householdId = await createHousehold('camille');
    await assertSucceeds(setDoc(doc(db('camille'), 'households', householdId, 'weekMeals', 'omelette'), weekMeal()));
    const ref = doc(db('alex'), 'households', householdId, 'weekMeals', 'omelette');
    await assertFails(getDoc(ref));
    await assertFails(setDoc(ref, weekMeal()));
    await assertFails(deleteDoc(ref));
  });

  test('un repas incohérent est refusé', async () => {
    const householdId = await createHousehold('camille');
    const ref = doc(db('camille'), 'households', householdId, 'weekMeals', 'omelette');
    await assertFails(setDoc(ref, weekMeal({ status: 'mangé' })));
    await assertFails(setDoc(ref, weekMeal({ idea: { ...idea, ingredients: [] } })));
    await assertFails(setDoc(ref, weekMeal({ note: 'x' })));
    await assertSucceeds(setDoc(ref, weekMeal()));
    await assertFails(updateDoc(ref, { status: 'jeté' }));
  });
});

describe('liste de courses', () => {
  test('un membre coche, ajoute et retire des articles', async () => {
    const householdId = await createHousehold('camille');
    const need = doc(db('camille'), 'households', householdId, 'shopping', 'need-oeuf-piece');
    const manual = doc(db('camille'), 'households', householdId, 'shopping', 'sacs');
    await assertSucceeds(setDoc(need, entry()));
    await assertSucceeds(setDoc(need, entry({ quantity: 12, category: 'dairy' })));
    await assertSucceeds(
      setDoc(manual, entry({ key: 'sac poubelle', name: 'Sacs poubelle', quantity: 1, manual: true, addedBy: 'Camille' })),
    );
    await assertSucceeds(getDoc(manual));
    await assertSucceeds(deleteDoc(manual));
  });

  test('la liste reste réservée au foyer', async () => {
    const householdId = await createHousehold('camille');
    const ref = (uid) => doc(db(uid), 'households', householdId, 'shopping', 'need-oeuf-piece');
    await assertSucceeds(setDoc(ref('camille'), entry()));
    await assertFails(getDoc(ref('alex')));
    await assertFails(setDoc(ref('alex'), entry()));
    await assertFails(deleteDoc(ref('alex')));
  });

  test('un article incohérent est refusé', async () => {
    const householdId = await createHousehold('camille');
    const ref = doc(db('camille'), 'households', householdId, 'shopping', 'x');
    await assertFails(setDoc(ref, entry({ name: '' })));
    await assertFails(setDoc(ref, entry({ quantity: 0 })));
    await assertFails(setDoc(ref, entry({ unit: 'tonne' })));
    await assertFails(setDoc(ref, entry({ checked: 'oui' })));
    await assertFails(setDoc(ref, entry({ dismissed: null })));
    await assertFails(setDoc(ref, entry({ price: 3 })));
  });
});
