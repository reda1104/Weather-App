import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherRepository {
  final WeatherService weatherService;

  WeatherRepository({required this.weatherService});

  Future<Weather> getWeather(String city) async {
    try {
      // Get weather data from service
      final weather = await weatherService.getWeather(city);
      return weather;
    } catch (e) {
      // Add error handling, logging, or fallback logic here
      throw Exception('Failed to get weather: $e');
    }
  }

  Future<Weather> getWeatherByLocation(double lat, double lon) async {
    try {
      // Get weather data from service
      final weather = await weatherService.getWeatherByCoords(lat, lon);
      return weather;
    } catch (e) {
      // Add error handling, logging, or fallback logic here
      throw Exception('Failed to get weather by location: $e');
    }
  }

  // You can add more methods like:
  // - getWeatherByLocation(lat, lon)
  // - getForecast(city)
  // - cache weather data
}
