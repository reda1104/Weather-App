import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/secrets.dart'; // Import your API key

abstract class WeatherService {
  Future<Weather> getWeather(String city);
  Future<Weather> getWeatherByCoords(double lat, double lon);
}

class OpenWeatherService implements WeatherService {
  @override
  Future<Weather> getWeather(String city) async {
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$openWeatherApiKey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      return _parseWeatherData(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      // City not found
      final json = jsonDecode(response.body);
      throw Exception(json["message"] ?? "City not found");
    } else {
      throw Exception('Failed to load weather: ${response.statusCode}');
    }
  }

  @override
  Future<Weather> getWeatherByCoords(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$openWeatherApiKey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      return _parseWeatherData(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather: ${response.statusCode}');
    }
  }

  Weather _parseWeatherData(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}

// Keep your mock service for testing
class MockWeatherService implements WeatherService {
  @override
  Future<Weather> getWeather(String city) async {
    await Future.delayed(const Duration(seconds: 1));
    return Weather(
      cityName: city,
      temperature: 22.5,
      condition: 'Sunny',
      humidity: 65.0,
      windSpeed: 5.2,
    );
  }

  @override
  Future<Weather> getWeatherByCoords(double lat, double lon) async {
    await Future.delayed(const Duration(seconds: 1));
    return Weather(
      cityName: "Mock City",
      temperature: 20.0,
      condition: 'Cloudy',
      humidity: 70.0,
      windSpeed: 4.0,
    );
  }
}

//Location

class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        "Location permissions are permanently denied, cannot request.",
      );
    }

    // ✅ Use LocationSettings instead of deprecated desiredAccuracy
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high, // High accuracy GPS
        distanceFilter: 0, // Update regardless of movement
        timeLimit: Duration(seconds: 8), // Timeout after 8s
      ),
    );
  }
}
