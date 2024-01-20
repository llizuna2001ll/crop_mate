import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/land_model.dart';

class LandApiService {
  static const String baseUrl = 'http://52.90.175.55:8888/api/v1/lands';

  Future<List<Land>> getAllLandsByUserId(String token, int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/all/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        List<Land> lands = responseData.map((data) => Land.fromJson(data)).toList();
        return lands;
      } else {
        throw Exception('Failed to load lands. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching lands: $error');
    }
  }

  Future<Land> getLandById(String token, int landId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$landId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        Land land = Land.fromJson(responseData);
        return land;
      } else {
        throw Exception('Failed to load land. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching land: $error');
    }
  }

  Future<void> addLand(String token, Land landRequest) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/addLand'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(landRequest.toJson()),
      );

      if (response.statusCode == 201) {
        print('Land added successfully');
      } else {
        throw Exception('Failed to add land. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error adding land: $error');
    }
  }
}
