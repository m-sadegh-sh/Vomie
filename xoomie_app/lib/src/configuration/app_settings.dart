abstract class AppSettingsBase {
  String get unsplashBaseUrl;
  String get unsplashAccessKey;
}

class EnvironmentBasedAppSettings implements AppSettingsBase {
  final Map<String, String> values;

  const EnvironmentBasedAppSettings({
    required this.values,
  });

  @override
  String get unsplashBaseUrl => values['UNSPLASH_BASE_URL']!;

  @override
  String get unsplashAccessKey => values['UNSPLASH_ACCESS_KEY']!;
}
