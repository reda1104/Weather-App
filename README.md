# Flutter Weather App

A Flutter app for checking current weather by city or device location. It combines OpenWeatherMap data with BLoC state management, animated weather visuals, and a dark interface.

## Screenshots

<img width="250" alt="Weather-App screenshot 1" src="https://github.com/user-attachments/assets/ea0843e2-7fa3-491c-a783-47ac9c9ddf22" />
<img width="250" alt="Weather-App screenshot 2" src="https://github.com/user-attachments/assets/f090c7ce-9fd5-43b4-8c7e-0968ee7a2275" />
<img width="250" alt="Weather-App screenshot 3" src="https://github.com/user-attachments/assets/92a07cdc-6c32-4e36-992d-52292ef24144" />

## Features

- Search for current weather by city name.
- Request device location at startup and fetch weather by coordinates.
- Display temperature in Celsius, weather condition, humidity, and wind speed.
- Pull to refresh the searched city, or use device location when the search field is empty.
- Lottie animations for sunny, cloudy, rainy, and error displays.
- Shimmer loading placeholders.
- Location-permission and disabled-location-service handling.

## Architecture

The app separates UI, BLoC, repository, and service responsibilities.

| Location | Responsibility |
| --- | --- |
| `weather_app/lib/views/weather_screen.dart` | Search, weather display, refresh gestures, and location requests |
| `weather_app/lib/blocs/` | Events and states for city lookup, coordinate lookup, and refresh |
| `weather_app/lib/repositories/weather_repository.dart` | Weather retrieval through an injected service |
| `weather_app/lib/services/weather_services.dart` | OpenWeatherMap HTTP requests, response parsing, mock service, and location helper |
| `weather_app/lib/models/weather_model.dart` | Typed weather data |
| `weather_app/lib/main.dart` | RepositoryProvider, BlocProvider, and theme setup |

The screen dispatches events to `WeatherBloc`. The BLoC calls `WeatherRepository`, which delegates to a `WeatherService`. Results become loading, loaded, or error states for the UI.

A `MockWeatherService` is included for trying the UI with sample weather data. `main.dart` currently injects `OpenWeatherService`; replace that constructor with `MockWeatherService()` to use the sample responses. Device-location requests remain separate.

## Tech stack

Flutter · Dart · flutter_bloc · Equatable · http · OpenWeatherMap · geolocator · Lottie · Shimmer · Google Fonts

## Run locally

Use a Flutter SDK whose bundled Dart version satisfies `^3.8.1`.

The Flutter project is inside `weather_app`:

```bash
git clone https://github.com/reda1104/Weather-App.git
cd Weather-App/weather_app
flutter pub get
```

1. Obtain your own [OpenWeatherMap API key](https://openweathermap.org/api) with access to the current-weather endpoint.
2. Configure `lib/secrets.dart` locally with the constant imported by the service:

```dart
const String openWeatherApiKey = 'YOUR_OPENWEATHER_API_KEY';
```

3. Keep your personal key out of commits.
4. Run on a device or emulator with internet access:

```bash
flutter run
```

Allow location access and enable location services for coordinate-based weather. On an emulator, configure a simulated location. City search can be used without granting location access.

## Scope

The app uses OpenWeatherMap's current-weather endpoint with metric units. It does not implement multi-day forecasts or offline weather caching. Platform folders are included; location permissions and behavior should be verified on each intended target.

## Author

[Mohamed Reda](https://github.com/reda1104)
