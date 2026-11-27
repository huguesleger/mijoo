part of 'package:mijoo/core/router/routes.dart';

@TypedGoRoute<BarcodePageRoute>(path: barcodePath, name: 'barcode')
class BarcodePageRoute extends GoRouteData with $BarcodePageRoute {
  const BarcodePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider<BarcodeCubit>(create: (_) => BarcodeCubit(), child: const BarcodeScreen());
}
