final initialQuestionnaire = {
  "type": "questionnaire",
  "title": "Πώς αισθάνεσαι σήμερα;",
  "questions": [
    {
      "id": "mood",
      "type": "single_choice",
      "question": "Διάθεση",
      "options": ["🙂 Καλά", "😐 ΟΚ", "😞 Άσχημα"],
    },
    {
      "id": "energy",
      "type": "slider",
      "question": "Ενέργεια (1-10)",
      "min": 1,
      "max": 10,
    },
  ],
  "submit": {"label": "Αποστολή"},
};
