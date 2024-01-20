import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/conversation_model.dart';
import '../models/message_model.dart';

class ChatBotApiService {
  static const String baseUrl = 'http://52.90.175.55:8888/api/v1'; // Base URL without endpoint

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

  Future<void> createMessage(String content, int conversationId) async {
    const String apiUrl = '$baseUrl/messages/sendMessage';

    Message newMessage = Message(
      messageContent: content,
      conversationId: conversationId,
    );

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newMessage.toJson()),
      );

      if (response.statusCode == 200) {
        print('Message created successfully!');
      } else {
        print('Failed to create message. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error creating message: $error');
    }
  }

  Future<List<Message>> fetchMessagesByConversationId(int conversationId) async {

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/messages/$conversationId'), // Adjust endpoint/query parameters as needed
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',

        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        List<Message> messages = responseData.map((data) => Message.fromJson(data)).toList();
        return messages;
      } else {
        throw Exception('Failed to load messages. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching messages: $error');
    }
  }



  Future<Conversation> createConversation(String username) async {
    const String apiUrl = '$baseUrl/conversations';

    Conversation newConversation = Conversation(
      username: username,
    );

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newConversation.toJson()),
      );

      if (response.statusCode == 200) {
        // If the request is successful, parse the response body
        return Conversation.fromJson(json.decode(response.body));
      } else {
        // If the request fails, throw an error or handle it accordingly
        throw Exception('Failed to create conversation. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error creating conversation: $error');
    }
  }

}
