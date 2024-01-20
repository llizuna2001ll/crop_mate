import 'package:flutter/material.dart';
import 'package:cropmate/models/message_model.dart';
import '../services/chatbot_api_service.dart';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(const Conversations());
}

class Conversations extends StatefulWidget {
  final conversationId;

  const Conversations({Key? key,@required this.conversationId}) : super(key: key);

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversations> {
  TextEditingController messageController = TextEditingController();
  final ChatBotApiService _apiService = ChatBotApiService();
  Timer? _timer;
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startPolling(); // Start polling for new messages
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _checkForNewMessages();
    });
  }

  void _checkForNewMessages() {
    _apiService.fetchMessagesByConversationId(widget.conversationId).then((messages) {
      setState(() {
        final List<Message> newMessages = messages.where((message) {
          return !_messages.contains(message); // Filter out existing messages
        }).toList();
        _messages.clear();
        _messages.addAll(newMessages);
      });
      _scrollToBottom(); // Scroll to the bottom when new messages arrive
    }).catchError((error) {
      print('Error while fetching new messages: $error');
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when disposing of the widget
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (BuildContext context, int index) {
              final message = _messages[index];
              final isUser = message.sender == "user";
              final decodedMessage = utf8.decode(message.messageContent.codeUnits);

              return Align(
                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5, // Set a percentage of screen width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: isUser ? const Radius.circular(15) : const Radius.circular(0),
                        bottomLeft: const Radius.circular(15),
                        bottomRight: const Radius.circular(15),
                        topRight: isUser ? const Radius.circular(0) : const Radius.circular(15),
                      ),
                      color: isUser ? const Color(0xFF4BA26A) : const Color(0x8CD9D9D9),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Text(
                        decodedMessage,
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  height: 41.0,
                  decoration: BoxDecoration(
                    color: const Color(0x8CD9D9D9),
                    borderRadius: BorderRadius.circular(10.5),
                  ),
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      hintText: 'Enter your message...',
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF808080), // Placeholder color
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0), // Adjust the space between TextField and IconButton
              GestureDetector(
                onTap: () {
                  if (messageController.text.isNotEmpty) {
                    _apiService.createMessage(messageController.text, widget.conversationId);
                    messageController.text = "";
                  }
                },
                child: Image.asset(
                  'lib/assets/images/send_icon.png',
                  width: 40.5,
                  height: 30.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

