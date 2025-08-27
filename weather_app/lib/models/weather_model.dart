class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final double humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
  });

  // We'll add fromJson later
}
