import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Conversation.dart';

class ChatBotApiService {
  static const String baseUrl = 'http://10.0.2.2:8888/api/v1'; // Base URL without endpoint

  Future<Conversation> getConversation(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/conversations/$username'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      return Conversation.fromJson(json.decode(response.body));
    } else {
      // If the request fails, throw an error or handle it accordingly
      throw Exception('Failed to load conversation');
    }
  }
}
