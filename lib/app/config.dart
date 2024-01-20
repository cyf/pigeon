enum Flavor { internal, external }

class AppConfig {
  AppConfig({required this.flavor});

  factory AppConfig.create({
    Flavor flavor = Flavor.internal,
  }) {
    return shared = AppConfig(flavor: flavor);
  }

  final Flavor flavor;

  bool get isExternal => flavor == Flavor.external;

  bool get isInternal => flavor == Flavor.internal;

  static AppConfig shared = AppConfig.create();
}
