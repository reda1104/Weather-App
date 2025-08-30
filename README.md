# Weather App

A beautiful Flutter application that provides real-time weather information for any city or your current location. The app features a modern UI, animated weather icons, and smooth state management using BLoC.

## Features

- 🌍 **Get Weather by City:** Search for any city worldwide and view current weather conditions.
- 📍 **Get Weather by Location:** Automatically fetch weather data based on your device's current location.
- 🌦 **Animated Weather Visuals:** Enjoy engaging Lottie animations for different weather conditions (sunny, cloudy, rainy, error).
- 🔄 **Pull-to-Refresh:** Easily refresh weather data with a swipe gesture.
- 💧 **Detailed Info:** View temperature, humidity, wind speed, and weather description.
- 🎨 **Modern UI:** Clean, responsive design with background images and custom fonts.
- ⚡ **State Management:** Powered by [flutter_bloc](https://pub.dev/packages/flutter_bloc) for robust and scalable state handling.

## Screenshots

<img width="1080" height="2400" alt="Screenshot_1756514350" src="https://github.com/user-attachments/assets/ea0843e2-7fa3-491c-a783-47ac9c9ddf22" />

<img width="1080" height="2400" alt="Screenshot_1756514394" src="https://github.com/user-attachments/assets/f090c7ce-9fd5-43b4-8c7e-0968ee7a2275" />

<img width="1080" height="2400" alt="Screenshot_1756514407" src="https://github.com/user-attachments/assets/92a07cdc-6c32-4e36-992d-52292ef24144" />



## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- An API key from [OpenWeatherMap](https://openweathermap.org/api)

### Project Structure

main.dart – App entry point and dependency injection.
weather_screen.dart – Main UI and user interaction.
weather_bloc.dart – BLoC for weather state management.
weather_repository.dart – Repository pattern for data access.
weather_services.dart – API integration and location services.
assets – Lottie animations and background images.
Dependencies
flutter_bloc
geolocator
http
lottie
google_fonts
shimmer


