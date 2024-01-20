import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/crop_response.dart';

class CropServiceApi {
  static const String baseUrl = 'http://52.90.175.55:8888/api/v1/crops';

  Future<List<CropResponse>> getAllCrops() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        List<dynamic> jsonList = json.decode(response.body);
        List<CropResponse> cropResponses = jsonList
            .map((json) {
          try {
            return CropResponse.fromJson(json);
          } catch (e) {
            print('Error parsing JSON for element: $json');
            throw e; // Re-throw the exception to maintain the original behavior
          }
        })
            .toList();
        return cropResponses;
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load crops');
      }
    } catch (e) {
      print('Error in getAllCrops: $e');
      rethrow; // Re-throw the exception to maintain the original behavior
    }
  }

  Future<CropResponse> getCropById(int cropId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$cropId'));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        Map<String, dynamic> jsonMap = json.decode(response.body);
        try {
          return CropResponse.fromJson(jsonMap);
        } catch (e) {
          print('Error parsing JSON: $e');
          throw e;
        }
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load crop with ID $cropId');
      }
    } catch (e) {
      print('Error in getCropById: $e');
      rethrow;
    }
  }

}