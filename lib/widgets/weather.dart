import 'package:flutter/material.dart';

import '../services/weather_service.dart';

class Weather extends StatelessWidget {
  final WeatherService weatherService = WeatherService();
  final String city = 'Casablanca'; // Replace with the desired city

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.2,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4BA26A),
                  Color(0xFF9DD0AF),
                  Color(0xFFBEE3CB),
                ],
                stops: [0.0039, 0.5453, 0.9939],
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FutureBuilder<Map<String, String>>(
              future: weatherService.fetchWeatherData(city),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final weatherData = snapshot.data ?? {
                    'temperature': 'N/A',
                    'country': 'N/A',
                    'city': 'N/A',
                    'condition': 'N/A',
                  };

                  final temperature = weatherData['temperature'];
                  final cityName = weatherData['city'];
                  final country = weatherData['country'];
                  final condition = weatherData['condition'];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        temperature!,
                        style: const TextStyle(
                            fontSize: 36.0, color: Colors.white),
                      ),
                      Text(
                        '${cityName!}, ${country!}',
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 290.0),
                        child: Image.asset(
                          "lib/assets/images/weather_icons/cloudy.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 300.0),
                        child: Text(
                          condition!,
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.white),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
