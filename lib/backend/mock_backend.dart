import '../jsons/initial_questionnaire.dart';

class MockBackend {
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

    return Map<String, dynamic>.from(initialQuestionnaire);
  }

  static Map<String, dynamic> sendAnswers(Map<String, dynamic> answers) {
    final mood = answers["mood"];
    final energy = answers["energy"] ?? 0;

    // 🔹 ΛΟΓΙΚΗ SERVER
    if (mood == "😞 Άσχημα" || energy < 4) {
      return {
        "type": "questionnaire",
        "title": "Θες λίγη βοήθεια;",
        "questions": [
          {
            "id": "support",
            "type": "single_choice",
            "question": "Τι θα σε βοηθούσε τώρα;",
            "options": [
              "Χαλαρωτικές ασκήσεις",
              "Συμβουλές",
              "Να μιλήσω με κάποιον",
            ],
          },
        ],
        "submit": {"label": "Συνέχεια"},
      };
    }

    // 🔹 ΑΛΛΗ ΠΕΡΙΠΤΩΣΗ → CARD
    return {
      "type": "card",
      "title": "Σύνοψη",
      "content": "Φαίνεται ότι είσαι σε καλή κατάσταση σήμερα 💪",
    };
  }
}
