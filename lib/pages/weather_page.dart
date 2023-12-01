import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:serenova/models/weather_model.dart';
import 'package:serenova/services/weather_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("0b2ce0485394821a7a509df96cbceab8");
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/weatherAnimations/sun.json";
    
    switch (mainCondition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/weatherAnimations/cloud.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/weatherAnimations/rain.json";
      case "thunderstorm":
        return "assets/weatherAnimations/thunder.json";
      case "clear":
        return "assets/weatherAnimations/sun.json";
      default:
        return "assets/weatherAnimations/sun.json";
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 36, 37),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  const Icon(
                    FontAwesomeIcons.locationDot,
                    size: 24.0,
                    color: Color.fromARGB(255, 103, 102, 104),
                  ),

                  Text(
                    _weather?.cityName ?? "Loading city...",
                    style: const TextStyle(
                      fontFamily: "Oswald",
                      fontSize: 24.0,
                      color: Color.fromARGB(255, 103, 102, 104)
                    ),
                  ),
                ],
              ),
            ),
            
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            
            Container(
              margin: const EdgeInsets.only(top: 90),
              child: Text(
                "${_weather?.temperature.round()}°",
                style: const TextStyle(
                  fontFamily: "Oswald",
                  fontSize: 48.0,
                  color: Color.fromARGB(255, 103, 102, 104)
                ),
              ),
            ),
            // Text(_weather?.mainCondition ?? "")
          ]
        ),
      ),
    );
  }
}