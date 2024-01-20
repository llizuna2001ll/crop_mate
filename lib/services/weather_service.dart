import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String baseUrl = 'http://3.90.175.149:8084/api/v1/weather';

  Future<Map<String, String>> fetchWeatherData(String city) async {
    final url = Uri.parse('$baseUrl?location=$city');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);
        final currentData = data?['current'];
        final locationData = data?['location'];

        if (currentData != null && locationData != null) {
          final tempC = currentData['temp_c'];
          final country = locationData['country'];
          final city = locationData['name'];
          final conditionText = currentData['condition']['text'];

          return {
            'temperature': '$tempC°C',
            'country': country,
            'city': city,
            'condition': conditionText,
          };
        }
      }
    } catch (e) {
      print('Exception occurred: $e');
    }

    return {
      'temperature': 'N/A',
      'country': 'N/A',
      'city': 'N/A',
      'condition': 'N/A',
    };
  }
}
