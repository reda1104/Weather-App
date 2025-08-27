import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather_model.dart'; // Import your model

// States represent what the UI should show
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

// Initial state - no data yet
class WeatherInitial extends WeatherState {}

// Loading state - show spinner
class WeatherLoading extends WeatherState {}

// Success state - show weather data
class WeatherLoaded extends WeatherState {
  final Weather weather;

  const WeatherLoaded(this.weather);

  @override
  List<Object> get props => [weather];
}

// Error state - show error message
class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
