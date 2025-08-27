import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/weather_services.dart';
import 'weather_events.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    // Handle FetchWeather events
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading()); // Show loading
      try {
        final weather = await weatherRepository.getWeather(event.city);
        emit(WeatherLoaded(weather)); // Show data
      } catch (e) {
        emit(WeatherError('Failed to fetch weather: $e')); // Show error
      }
    });

    // Handle RefreshWeather events
    on<RefreshWeather>((event, emit) async {
      try {
        final weather = await weatherRepository.getWeather(event.city);
        emit(WeatherLoaded(weather)); // Update with fresh data
      } catch (e) {
        emit(WeatherError('Failed to refresh weather: $e'));
      }
    });

    on<FetchWeatherByCoords>((event, emit) async {
      emit(WeatherLoading()); // Show loading
      try {
        final weather = await weatherRepository.getWeatherByLocation(
          event.lat,
          event.lon,
        );
        emit(WeatherLoaded(weather)); // Show data
      } catch (e) {
        emit(WeatherError('Failed to fetch weather: $e')); // Show error
      }
    });
  }
}
