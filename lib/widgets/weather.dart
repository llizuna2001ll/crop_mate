import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class Weather extends StatelessWidget {
  final WeatherService weatherService = WeatherService();
  final String city = 'Casablanca'; // Replace with the desired city

  @override
  Widget build(BuildContext context) {
    return Container(
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
        boxShadow: [ // Define the boxShadow property here
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      temperature!,
                      style: const TextStyle(
                        fontSize: 48.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text(
                        '${cityName!}, ${country!}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      condition!,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Image.asset(
                    "lib/assets/images/weather_icons/cloudy.png",
                    fit: BoxFit.contain,
                    height: 100,
                    width: 100,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
