part of 'package:mijoo/core/router/routes.dart';

@TypedGoRoute<ScanPageRoute>(path: scanPath, name: 'scan')
class ScanPageRoute extends GoRouteData with $ScanPageRoute {
  const ScanPageRoute({required this.source});

  final PhotoSource source;

  @override
  Widget build(BuildContext context, GoRouterState state) => switch (context.read<SessionCubit>().state) {
    SignedIn(household: HouseholdFound(:final household)) => BlocProvider<ScanCubit>(
      create: (_) => ScanCubit(household: household.id, source: source)..start(),
      child: const ScanScreen(),
    ),
    SignedIn() || SessionUnknown() || SignedOut() => const LaunchScreen(),
  };
}
