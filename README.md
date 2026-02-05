# SDUI Chatbot (Πτυχιακή)

A new Flutter project.
Πρωτότυπο ψηφιακού βοηθού όπου οι απαντήσεις δεν είναι μόνο κείμενο αλλά **JSON**
που περιγράφει UI. Η Flutter εφαρμογή αποδίδει δυναμικά αυτά τα components μέσα
στο chat, προσομοιώνοντας Server-Driven UI (SDUI).

## Τι δείχνει το demo

1. Ο χρήστης στέλνει μήνυμα.
2. Ο “server” (mock backend) επιστρέφει **SDUI JSON** (π.χ. κάρτα, οδηγίες,
   ερωτηματολόγιο).
3. Η εφαρμογή αποδίδει τα components με βάση τον renderer.


## Παραδείγματα prompts

- “καιρός” → κάρτα καιρού
- “οδηγίες” → βήματα επίλυσης
- “ερωτηματολόγιο” → φόρμα πολλαπλών ερωτήσεων

## SDUI JSON format (ενδεικτικό)

```json
{
  "type": "instructions",
  "title": "Βήματα",
  "subtitle": "Παράδειγμα",
  "steps": ["Βήμα 1", "Βήμα 2"],
  "actions": [{ "label": "Επόμενο" }]
}
```

## Δομή κώδικα (βασικά σημεία)

- `lib/screens/chat_screen.dart`: chat ροή + απόδοση SDUI μέσα στα bubbles
- `lib/renderers/sdui_renderer.dart`: renderer που μεταφράζει JSON → UI
- `lib/backend/mock_backend.dart`: “server” που παράγει JSON βάσει prompt

## Run (Flutter)

```bash
flutter pub get
flutter run
```