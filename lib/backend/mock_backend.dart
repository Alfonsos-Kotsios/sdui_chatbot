import '../jsons/initial_questionnaire.dart';

class MockBackend {
  static const String _rfwLibrary = '''
import core.widgets;

widget root = Directionality(
  textDirection: ltr,
  child: Center(
    child: Text(
      text: 'Γεια σου από RFW',
    ),
  ),
);
''';

  static const String _rfwData = '''
{
  "message": "Γεια σου από RFW!"
}
''';

  static Map<String, dynamic> handleUserMessage(String message) {
    final normalized = message.toLowerCase();

    if (normalized.contains('καιρ')) {
      return {
        "type": "card",
        "title": "Κάρτα Καιρού",
        "content": "Αύριο προβλέπεται ηλιοφάνεια ☀️ με 24°C.",
        "icon": "☀️",
      };
    }

    if (normalized.contains('οδηγ') || normalized.contains('βήμα')) {
      return {
        "type": "instructions",
        "title": "Βήματα για επίλυση προβλήματος",
        "subtitle": "Παράδειγμα: απλό μαθηματικό πρόβλημα",
        "steps": [
          "Διάβασε προσεκτικά την εκφώνηση.",
          "Κατάγραψε τα δεδομένα και το ζητούμενο.",
          "Επίλεξε τη μέθοδο (π.χ. εξίσωση, πίνακας, γράφημα).",
          "Λύσε και έλεγξε το αποτέλεσμα.",
        ],
        "actions": [
          {"label": "Δώσε νέο πρόβλημα"},
          {"label": "Εμφάνισε παράδειγμα"},
        ],
      };
    }

    if (normalized.contains('ερωτηματολ')) {
      return {
        "type": "questionnaire",
        "title": "Γρήγορο ερωτηματολόγιο παραγωγικότητας",
        "questions": [
          {
            "id": "focus",
            "type": "single_choice",
            "question": "Πόσο συγκεντρωμένος/η νιώθεις;",
            "options": ["🔋 Πολύ", "🙂 Μέτρια", "😴 Λίγο"],
          },
          {
            "id": "tasks",
            "type": "text_input",
            "question": "Ποια 3 tasks είναι προτεραιότητα σήμερα;",
            "placeholder": "π.χ. διάβασμα, εργασία, προπόνηση",
          },
        ],
        "submit": {"label": "Υποβολή"},
      };
    }

    if (normalized.contains('rfw') || normalized.contains('remote')) {
      return {
        "type": "rfw",
        "title": "RFW Demo",
        "library": _rfwLibrary,
        "data": _rfwData,
      };
    }

    return Map<String, dynamic>.from(initialQuestionnaire);
  }
}
