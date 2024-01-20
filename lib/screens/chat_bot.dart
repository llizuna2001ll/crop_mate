import 'package:flutter/material.dart';
import 'package:cropmate/models/conversation_model.dart';
import 'package:cropmate/screens/home.dart';
import 'package:cropmate/services/chatbot_api_service.dart';
import 'package:cropmate/widgets/conversation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../widgets/navbar.dart';

void main() {
  runApp(const ChatBot());
}

class ChatBot extends StatefulWidget {
  final token;

  const ChatBot({Key? key, @required this.token}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final ChatBotApiService _apiService = ChatBotApiService();
  late String username;
  late Future<Conversation> _conversation;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    username = jwtDecodedToken['sub'];
    _conversation = _apiService.getConversation(username);
  }

  Future<void> startConversation() async {
    try {
      // Call the createConversation method to create a new conversation
      await _apiService.createConversation(username);

      // Reload the current page using pushReplacement
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChatBot(token: widget.token),
        ),
      );
    } catch (error) {
      print('Error creating conversation: $error');
      // Handle the error accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: const Navbar(
          selectedIndex: 2,
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              size: 40,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => Home(token: widget.token),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeOutCubic;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
          title: const Text(
            'Boba',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'PT_Sans'),
          ),
        ),
        body: Center(
          child: FutureBuilder<Conversation>(
            future: _conversation,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('Loading...');
                return const CircularProgressIndicator();
              } else if (!snapshot.hasData) {
                print('No data or empty data.');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Image.asset(
                      'lib/assets/images/chatbot_icon.png',
                      width: 270,
                      height: 330,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome, User',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'PT_Sans'),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Let’s start a conversation with Boba',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'PT_Sans'),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: startConversation,
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF4BA26A),
                        minimumSize: const Size(300, 50), // Set minimum size
                      ),
                      child: const Text(
                        'Start',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                Conversation conversation = snapshot.data!;
                print('Conversation ID: ${conversation.id}');
                print('Messages: ${conversation.username}');
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child:  Conversations(conversationId: conversation.id),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
