enum Flavor { internal, external }

class AppConfig {
  AppConfig({required this.flavor});

  factory AppConfig.create({
    Flavor flavor = Flavor.internal,
  }) {
    return shared = AppConfig(flavor: flavor);
  }

  final Flavor flavor;

  static AppConfig shared = AppConfig.create();
}
