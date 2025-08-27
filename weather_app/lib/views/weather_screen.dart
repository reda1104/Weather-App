import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/blocs/weather_events.dart';
import 'package:weather_app/blocs/weather_state.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  final LocationService _locationService = LocationService();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _getWeatherByLocation(BuildContext context) async {
    try {
      Position pos = await _locationService.getCurrentLocation();
      context.read<WeatherBloc>().add(
        FetchWeatherByCoords(pos.latitude, pos.longitude),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Widget _buildWeatherAnimation(String condition) {
    if (condition.toLowerCase().contains("cloud")) {
      return Lottie.asset("assets/animations/cloudy.json", height: 150);
    } else if (condition.toLowerCase().contains("rain")) {
      return Lottie.asset("assets/animations/rain.json", height: 150);
    } else {
      return Lottie.asset("assets/animations/sunny.json", height: 150);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Weather App", style: GoogleFonts.poppins()),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Column(
            children: [
              // 🔎 Search bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cityController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter city name",
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.black26,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_cityController.text.isNotEmpty) {
                        context.read<WeatherBloc>().add(
                          FetchWeather(_cityController.text),
                        );
                      }
                    },
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Location button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white24,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _getWeatherByLocation(context),
                icon: const Icon(Icons.my_location, color: Colors.white),
                label: const Text(
                  "My Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),

              // Weather Bloc
              Expanded(
                child: Center(
                  child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherLoading) {
                        return Shimmer.fromColors(
                          baseColor: Colors.white24,
                          highlightColor: Colors.white54,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 200,
                                height: 20,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: 100,
                                height: 100,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        );
                      } else if (state is WeatherLoaded) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildWeatherAnimation(state.weather.condition),
                            Text(
                              state.weather.cityName,
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${state.weather.temperature}°C",
                              style: GoogleFonts.poppins(
                                fontSize: 64,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              state.weather.condition,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildInfoTile(
                                  "💧 Humidity",
                                  "${state.weather.humidity}%",
                                ),
                                const SizedBox(width: 16),
                                _buildInfoTile(
                                  "🌬 Wind",
                                  "${state.weather.windSpeed} m/s",
                                ),
                              ],
                            ),
                          ],
                        );
                      } else if (state is WeatherError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              "assets/animations/error.json",
                              height: 150,
                            ),
                            Text(
                              "Oops! City not found",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      }
                      return Text(
                        "Search for a city to begin",
                        style: GoogleFonts.poppins(color: Colors.white70),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
