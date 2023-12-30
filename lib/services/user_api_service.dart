import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApiService {
  static const String baseUrl = 'http://10.0.2.2:8888/api/v1/auth';

  Future<Map<String, dynamic>> loginUser(String username, String password) async {
    final url = Uri.parse('$baseUrl/authenticate');
    final body = jsonEncode({'username': username, 'password': password});

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {

        final responseData = jsonDecode(response.body);
        return {'success': true, 'data': responseData};
      } else {
        return {'success': false, 'error': 'Failed to log in'};
      }
    } catch (e) {
      return {'success': false, 'error': 'Exception occurred: $e'};
    }
  }

  Future<Map<String, dynamic>> signUpUser(String username, String password, String email, String city, String contactNumber) async {
    final url = Uri.parse('$baseUrl/register');
    final body = jsonEncode({
      'username': username,
      'password': password,
      'email': email,
      'city': city,
      'contactNumber': contactNumber
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        // Successful login, you might handle the response here
        final responseData = jsonDecode(response.body);
        return {'success': true, 'data': responseData};
      } else{
        final errorResponse = jsonDecode(response.body);
        if (errorResponse.containsKey('error')) {
          return {'success': false, 'error': errorResponse['error']};
        } else {
          return {'success': false, 'error': 'Failed to Sign up'};
        }
      }
    } catch (e) {
      return {'success': false, 'error': 'Exception occurred: $e'};
    }
  }

}
