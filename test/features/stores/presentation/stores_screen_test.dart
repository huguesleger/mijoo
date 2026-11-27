import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/stores/domain/entities/store_kind.dart';
import 'package:mijoo/features/stores/domain/entities/store_radius.dart';
import 'package:mijoo/features/stores/domain/stores_repository.dart';
import 'package:mijoo/features/stores/presentation/bloc/stores_cubit.dart';
import 'package:mijoo/features/stores/presentation/stores_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_screen.dart';
import '../stores_fixtures.dart';

class MockStoresRepository extends Mock implements StoresRepository {}

void main() {
  const town = HouseholdLocation(postalCode: '69001', city: 'Lyon');
  late MockStoresRepository repository;

  setUpAll(() {
    registerFallbackValue(town);
    registerFallbackValue(lyon);
    registerFallbackValue(StoreRadius.near);
  });

  setUp(() {
    repository = MockStoresRepository();
    when(() => repository.locateTown(any())).thenReturn(TaskEither.right(lyon));
    when(() => repository.storesAround(any(), any(), remember: any(named: 'remember'))).thenReturn(
      TaskEither.right([
        store('Monoprix', north: 350, hours: 'Mo-Sa 08:00-21:00', address: 'Rue de la République'),
        store('La Boulangerie Rouge', kind: StoreKind.bakery, north: 650, hours: 'Mo 08:00-19:00'),
        store('Marché Saint-Antoine', kind: StoreKind.marketplace, north: 900),
      ]),
    );
  });

  Future<void> pump(WidgetTester tester, Option<HouseholdLocation> household) => pumpScreen(
    tester,
    BlocProvider<StoresCubit>(
      create: (_) => StoresCubit(
        town: household,
        repository: repository,
        minimalLoading: Duration.zero,
        clock: () => DateTime(2026, 11, 27, 10),
      )..search(),
      child: const StoresScreen(),
    ),
  );

  testWidgets('lists the stores around the town, nearest first', (WidgetTester tester) async {
    await pump(tester, some(town));
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.text('Lyon · 69001'), findsOneWidget);
    expect(find.text('3 magasins à moins de 1 km'), findsOneWidget);
    expect(find.text('Supermarché · Rue de la République'), findsOneWidget);
    expect(find.text('Ouvert · ferme à 21:00'), findsOneWidget);
    expect(find.text('Fermé · ouvre lundi à 8:00'), findsOneWidget);
    expect(find.text('Horaires non renseignés'), findsOneWidget);
    expect(find.text('350 m'), findsOneWidget);
  });

  testWidgets('filters by kind of store', (WidgetTester tester) async {
    await pump(tester, some(town));
    await tester.pump();
    await tester.ensureVisible(find.text('Boulangeries'));
    await tester.pump();
    await tester.tap(find.text('Boulangeries'));
    await tester.pump();
    expect(find.text('1 magasin à moins de 1 km'), findsOneWidget);
    expect(find.text('Monoprix'), findsNothing);
  });

  testWidgets('opens the sheet of a store with its week', (WidgetTester tester) async {
    await pump(tester, some(town));
    await tester.pump();
    await tester.tap(find.text('Monoprix'));
    await tester.pumpAndSettle();
    expect(find.text('Vendredi, aujourd’hui'), findsOneWidget);
    expect(find.text('Dimanche'), findsOneWidget);
    expect(find.text('Itinéraire'), findsOneWidget);
  });

  testWidgets('asks where to search without a town', (WidgetTester tester) async {
    await pump(tester, none());
    await tester.pump();
    expect(find.text('Où chercher ?'), findsOneWidget);
    expect(find.text('Renseigner ma commune'), findsOneWidget);
    await tester.tap(find.text('Ma position'));
    await tester.pumpAndSettle();
    expect(find.text('Chercher autour de toi ?'), findsOneWidget);
    expect(find.text('Pas maintenant'), findsOneWidget);
  });
}
