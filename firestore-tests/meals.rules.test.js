import { readFileSync } from 'node:fs';
import { after, before, beforeEach, describe, test } from 'node:test';
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from '@firebase/rules-unit-testing';
import {
  addDoc,
  collection,
  deleteDoc,
  doc,
  getDoc,
  getDocs,
  serverTimestamp,
  setDoc,
  updateDoc,
  writeBatch,
} from 'firebase/firestore';

const idea = (overrides = {}) => ({
  id: 'gratin-epinards',
  title: 'Gratin d’épinards',
  description: 'Un gratin fondant pour finir les épinards.',
  prepMinutes: 10,
  cookMinutes: 15,
  servings: 4,
  kind: 'oven',
  difficulty: 'easy',
  equipment: ['Plat à gratin', 'Poêle'],
  photo: 'https://www.themealdb.com/images/media/meals/yvpuuy1511797244.jpg',
  ingredients: Array.from({ length: 12 }, (_, index) => ({
    name: `Ingrédient ${index}`,
    quantity: 1.5,
    unit: 'gram',
    category: 'fruitsVegetables',
    substitute: index % 2 ? 'Autre' : null,
  })),
  steps: Array.from({ length: 7 }, (_, index) => ({ text: `Étape ${index + 1}.`, minutes: index % 2 ? 5 : null })),
  ...overrides,
});

const plan = (overrides = {}) => ({
  craving: 'any',
  createdAt: serverTimestamp(),
  ideas: [idea(), idea({ id: 'pates', title: 'Pâtes', kind: 'pasta' }), idea({ id: 'soupe', title: 'Soupe' })],
  ...overrides,
});

let env;

before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-mijoo-meals',
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
  batch.set(household, { memberIds: [uid], createdBy: uid, createdAt: serverTimestamp(), profile: null });
  batch.set(doc(firestore, 'users', uid), { householdId: household.id });
  await batch.commit();
  return household.id;
}

const currentPlan = (uid, householdId) => doc(db(uid), 'households', householdId, 'mealPlans', 'current');
const cooked = (uid, householdId) => collection(db(uid), 'households', householdId, 'cookedMeals');

describe('idées de repas du foyer', () => {
  test('un membre enregistre puis remplace les idées du foyer', async () => {
    const householdId = await createHousehold('camille');
    await assertSucceeds(setDoc(currentPlan('camille', householdId), plan()));
    await assertSucceeds(setDoc(currentPlan('camille', householdId), plan({ craving: 'quick' })));
    await assertSucceeds(getDoc(currentPlan('camille', householdId)));
  });

  test('un autre parent ne lit ni n’écrit les idées', async () => {
    const householdId = await createHousehold('camille');
    await assertSucceeds(setDoc(currentPlan('camille', householdId), plan()));
    await assertFails(getDoc(currentPlan('alex', householdId)));
    await assertFails(setDoc(currentPlan('alex', householdId), plan()));
  });

  test('des idées incohérentes sont refusées', async () => {
    const householdId = await createHousehold('camille');
    const ref = currentPlan('camille', householdId);
    await assertFails(setDoc(ref, plan({ ideas: [] })));
    await assertFails(setDoc(ref, plan({ ideas: [idea(), idea(), idea(), idea()] })));
    await assertFails(setDoc(ref, plan({ ideas: [idea({ prepMinutes: '25' })] })));
    await assertFails(setDoc(ref, plan({ ideas: [idea({ photo: 42 })] })));
    await assertFails(setDoc(ref, plan({ ideas: [idea({ description: 'x'.repeat(201) })] })));
    await assertSucceeds(setDoc(ref, plan({ ideas: [idea({ photo: null })] })));
    await assertFails(setDoc(ref, plan({ ideas: [idea({ ingredients: [] })] })));
    await assertFails(setDoc(ref, plan({ ideas: [idea(), idea(), idea({ steps: 'Cuire' })] })));
    await assertFails(setDoc(ref, plan({ ideas: [idea({ price: 3 })] })));
    await assertFails(setDoc(ref, plan({ price: 12 })));
    await assertFails(setDoc(doc(db('camille'), 'households', householdId, 'mealPlans', 'autre'), plan()));
  });

  test('les idées ne se suppriment pas', async () => {
    const householdId = await createHousehold('camille');
    await assertSucceeds(setDoc(currentPlan('camille', householdId), plan()));
    await assertFails(deleteDoc(currentPlan('camille', householdId)));
  });
});

describe('historique des repas cuisinés', () => {
  test('un membre ajoute un repas cuisiné et lit l’historique', async () => {
    const householdId = await createHousehold('camille');
    await assertSucceeds(addDoc(cooked('camille', householdId), { title: 'Gratin', cookedAt: serverTimestamp() }));
    await assertSucceeds(getDocs(cooked('camille', householdId)));
  });

  test('l’historique reste réservé au foyer et ne se modifie pas', async () => {
    const householdId = await createHousehold('camille');
    const ref = await addDoc(cooked('camille', householdId), { title: 'Gratin', cookedAt: serverTimestamp() });
    await assertFails(getDocs(cooked('alex', householdId)));
    await assertFails(addDoc(cooked('alex', householdId), { title: 'Gratin', cookedAt: serverTimestamp() }));
    await assertFails(updateDoc(doc(db('camille'), ref.path), { title: 'Autre' }));
    await assertFails(deleteDoc(doc(db('camille'), ref.path)));
  });

  test('un repas cuisiné incohérent est refusé', async () => {
    const householdId = await createHousehold('camille');
    await assertFails(addDoc(cooked('camille', householdId), { title: '', cookedAt: serverTimestamp() }));
    await assertFails(addDoc(cooked('camille', householdId), { title: 'Gratin', cookedAt: new Date(0) }));
    await assertFails(
      addDoc(cooked('camille', householdId), { title: 'Gratin', cookedAt: serverTimestamp(), note: 'x' }),
    );
  });
});
