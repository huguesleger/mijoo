import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/router/app_router.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/fridge/domain/fridge_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_member.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/entities/meal_plan.dart';
import 'package:mijoo/features/meals/domain/meals_repository.dart';
import 'package:mijoo/features/session/presentation/bloc/session_cubit.dart';
import 'package:mijoo/features/shopping/domain/shopping_repository.dart';
import 'package:mijoo/features/shopping/domain/use_cases/watch_shopping_week.dart';
import 'package:mocktail/mocktail.dart';

import '../../features/meals/meals_fixtures.dart';
import '../../features/shopping/shopping_fixtures.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockHouseholdRepository extends Mock implements HouseholdRepository {}

class MockFridgeRepository extends Mock implements FridgeRepository {}

class MockMealsRepository extends Mock implements MealsRepository {}

class MockShoppingRepository extends Mock implements ShoppingRepository {}

void main() {
  const account = Account(id: AccountId('camille'), email: 'camille@exemple.fr', name: None());
  const householdId = HouseholdId('h1');
  final household = Household(id: householdId, memberIds: const [AccountId('camille')], profile: some(profile));
  final idea = mealIdea();
  late StreamController<Option<Household>> households;
  late StreamController<Option<Account>> accounts;

  setUpAll(() {
    registerFallbackValue(const HouseholdMember(id: AccountId('x'), name: 'x'));
    registerShoppingFallbacks();
  });

  setUp(() {
    households = StreamController<Option<Household>>.broadcast();
    accounts = StreamController<Option<Account>>.broadcast();
    final auth = MockAuthRepository();
    final householdRepository = MockHouseholdRepository();
    final fridge = MockFridgeRepository();
    final meals = MockMealsRepository();
    when(auth.watchSession).thenAnswer((_) => accounts.stream);
    when(() => householdRepository.watchHousehold(account.id)).thenAnswer((_) => households.stream);
    when(() => householdRepository.watchMembers(householdId)).thenAnswer((_) => Stream.value(right(const [])));
    when(() => householdRepository.saveMember(householdId, any())).thenReturn(TaskEither.right(unit));
    when(() => fridge.watchItems(householdId)).thenAnswer((_) => Stream.value(right([fridgeItem('Oeufs')])));
    when(() => meals.watchPlan(householdId)).thenAnswer(
      (_) => Stream.value(right(some(MealPlan(ideas: [idea], craving: MealCraving.any, createdAt: today)))),
    );
    when(() => meals.watchWeek(householdId)).thenAnswer((_) => Stream.value(right(const [])));
    final shopping = MockShoppingRepository();
    when(() => shopping.watchEntries(householdId)).thenAnswer((_) => Stream.value(right(const [])));
    stubPricesAndExpenses(shopping, householdId);
    getIt
      ..registerSingleton<ShoppingRepository>(shopping)
      ..registerFactory<WatchShoppingWeek>(WatchShoppingWeek.new)
      ..registerSingleton<AuthRepository>(auth)
      ..registerSingleton<HouseholdRepository>(householdRepository)
      ..registerSingleton<FridgeRepository>(fridge)
      ..registerSingleton<MealsRepository>(meals);
  });

  tearDown(() async {
    await households.close();
    await accounts.close();
    await getIt.reset();
  });

  Future<GoRouter> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final session = SessionCubit();
    final router = buildAppRouter(session);
    addTearDown(router.dispose);
    addTearDown(session.close);
    await tester.pumpWidget(
      TranslationProvider(
        child: BlocProvider<SessionCubit>.value(
          value: session,
          child: MaterialApp.router(
            theme: MjTheme.light(),
            locale: AppLocale.fr.flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            routerConfig: router,
          ),
        ),
      ),
    );
    await tester.pump();
    accounts.add(some(account));
    await tester.pump();
    households.add(some(household));
    await tester.pump(const Duration(seconds: 1));
    return router;
  }

  testWidgets('keeps the tabs when the household changes under a recipe', (WidgetTester tester) async {
    final router = await pumpApp(tester);
    router.go('/meals');
    await tester.pump(const Duration(seconds: 1));
    unawaited(router.push<void>('/meal/${idea.id.value}'));
    await tester.pump(const Duration(seconds: 1));

    households.add(some(household));
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);

    router.pop();
    await tester.pump(const Duration(seconds: 1));
    households.add(some(household));
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps the tabs when the household changes under the account', (WidgetTester tester) async {
    final router = await pumpApp(tester);
    unawaited(router.push<void>('/account'));
    await tester.pump(const Duration(seconds: 1));
    unawaited(router.push<void>('/household'));
    await tester.pump(const Duration(seconds: 1));

    households.add(some(household));
    await tester.pump(const Duration(seconds: 1));
    router.pop();
    await tester.pump(const Duration(seconds: 1));
    router.pop();
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
  });

  testWidgets('switches tabs from the home screen', (WidgetTester tester) async {
    final router = await pumpApp(tester);
    router.go('/shopping');
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
    router.go('/meals');
    await tester.pump(const Duration(seconds: 1));
    router.go('/home');
    await tester.pump(const Duration(seconds: 1));
    households.add(some(household));
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
  });

  testWidgets('closes the household edit while the household changes', (WidgetTester tester) async {
    final router = await pumpApp(tester);
    unawaited(router.push<void>('/account'));
    await tester.pump(const Duration(seconds: 1));
    unawaited(router.push<void>('/household'));
    await tester.pump(const Duration(seconds: 1));

    households.add(some(household));
    router.pop();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
  });

  testWidgets('signs out from the account page', (WidgetTester tester) async {
    final router = await pumpApp(tester);
    router.go('/meals');
    await tester.pump(const Duration(seconds: 1));
    unawaited(router.push<void>('/account'));
    await tester.pump(const Duration(seconds: 1));

    accounts.add(none());
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);

    accounts.add(some(account));
    await tester.pump();
    households.add(some(household));
    await tester.pump(const Duration(seconds: 1));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 5));
  });
}
