import 'package:equatable/equatable.dart';

// Events are user actions that trigger state changes
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

// Fetches weather for a city
class FetchWeather extends WeatherEvent {
  final String city;

  const FetchWeather(this.city);

  @override
  List<Object> get props => [city];
}

class FetchWeatherByCoords extends WeatherEvent {
  final double lat;
  final double lon;

  const FetchWeatherByCoords(this.lat, this.lon);

  @override
  List<Object> get props => [lat, lon];
}

// Refreshes weather data
class RefreshWeather extends WeatherEvent {
  final String city;

  const RefreshWeather(this.city);

  @override
  List<Object> get props => [city];
}
