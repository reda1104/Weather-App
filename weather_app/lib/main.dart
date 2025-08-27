import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/views/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData.dark(),
      home: RepositoryProvider(
        create: (context) =>
            WeatherRepository(weatherService: OpenWeatherService()),
        child: BlocProvider(
          create: (context) => WeatherBloc(
            weatherRepository: RepositoryProvider.of<WeatherRepository>(
              context,
            ),
          ),
          child: const WeatherScreen(),
        ),
      ),
    );
  }
}
