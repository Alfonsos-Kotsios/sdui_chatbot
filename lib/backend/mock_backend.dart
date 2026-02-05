class MockBackend {
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
