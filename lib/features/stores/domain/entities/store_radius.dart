enum StoreRadius {
  short(500),
  near(1000),
  medium(2000),
  far(5000)
  ;

  const StoreRadius(this.meters);

  final int meters;
}
