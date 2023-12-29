class EnvironmentConfig {
  static const FTPE_URL_API = String.fromEnvironment(
      'FTPE_URL_API',
      defaultValue: "https://localhost:6050"
  );

  static const ALERTS_TOPIC = String.fromEnvironment(
      'ALERTS_TOPIC',
      defaultValue: "alerts"
  );
}