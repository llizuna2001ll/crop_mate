class Message {
  final String messageContent;
  final int conversationId;
  final String? timestamp;
  final String? sender;

  Message({
    required this.messageContent,
    required this.conversationId,
    this.sender,
    this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageContent: json['messageContent'] ?? '',
      conversationId: json['id'] ?? 0, // Directly accessing the conversation ID
      sender: json['sender'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageContent': messageContent,
      'conversation': {'id': conversationId},
      'sender': sender,
      'timestamp': timestamp,
    };
  }
}

