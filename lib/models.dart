class ChatMessage {
  final String id;
  final bool isUser;
  final Map<String, dynamic>? sduiJson;
  final String? text;

  ChatMessage({
    required this.id,
    required this.isUser,
    this.sduiJson,
    this.text,
  });
}
