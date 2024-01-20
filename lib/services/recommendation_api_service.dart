import 'dart:convert';

import '../models/recommendation_response.dart';
import 'package:http/http.dart' as http;

class RecommendationApiService {
  static const String baseUrl = 'http://52.90.175.55:8888/api/v1/recommendations';


  Future<List<RecommendationResponse>> getAllRecommendationsByLandId(String token, int landId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/all/$landId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        print("code is here1");
        List<RecommendationResponse> recommendations = responseData.map((data) {
          try {
            print("Attempting to convert data to RecommendationResponse: $data");
            return RecommendationResponse.fromJson(data);
          } catch (error) {
            print("Error converting data to RecommendationResponse: $error");
            throw Exception('Error converting data to RecommendationResponse: $error');
          }
        }).toList();
        print("code is here2");
        // Print the raw response body
        print('Raw Response Body: ${response.body}');

        return recommendations;
      } else {
        throw Exception('Failed to load recommendations. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching recommendations: $error');
    }
  }



}