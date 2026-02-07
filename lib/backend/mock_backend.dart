import '../jsons/initial_questionnaire.dart';

class MockBackend {
  static Map<String, dynamic> handleUserMessage(String message) {
    final normalized = message.toLowerCase();

    if (normalized.contains('καιρ')) {
      return {
        "type": "rfw_card",
        "data": {
          "title": "Κάρτα Καιρού",
          "content": "Αύριο προβλέπεται ηλιοφάνεια ☀️ με 24°C.",
          "icon": "☀️",
        },
      };
    }
    return Map<String, dynamic>.from(initialQuestionnaire);
  }
}
