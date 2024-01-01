import 'package:flutter/material.dart';

void main() {
  runApp(const Conversations());
}

class Conversations extends StatefulWidget {
  const Conversations({Key? key}) : super(key: key);

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversations> {
  List<String> messages = [];
  TextEditingController messageController = TextEditingController();

  void sendMessage(String message) {
    setState(() {
      messages.add(message);
    });
    print('Sending message: $message');
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(messages[index]),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          height: 41.0,
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(10.5),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 30.0,
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                      hintText: 'Enter your message...',
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF808080), // Placeholder color
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
