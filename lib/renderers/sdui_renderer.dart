import 'package:flutter/material.dart';

class SDUIRenderer extends StatelessWidget {
  final Map<String, dynamic> json;
  final Map<String, dynamic> answers;
  final Function(String, dynamic) onAnswer;
  final VoidCallback? onSubmit;

  const SDUIRenderer({
    super.key,
    required this.json,
    required this.answers,
    required this.onAnswer,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    switch (json["type"]) {
      case "questionnaire":
        return _buildQuestionnaire();
      case "card":
        return _buildCard();
      default:
        return const Text("Unknown SDUI type");
    }
  }

  Widget _buildQuestionnaire() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          json["title"],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        ...json["questions"].map<Widget>((q) {
          return _buildQuestion(q);
        }).toList(),

        const SizedBox(height: 12),

        if (json["submit"] != null)
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onSubmit,
              child: Text(json["submit"]["label"] ?? "Submit"),
            ),
          ),
      ],
    );
  }

  Widget _buildQuestion(Map<String, dynamic> q) {
    switch (q["type"]) {
      case "single_choice":
        return _buildSingleChoice(q);
      case "slider":
        return _buildSlider(q);
      case "text_input":
        return _buildTextInput(q);
      default:
        return const SizedBox();
    }
  }

  Widget _buildSingleChoice(Map<String, dynamic> q) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          q["question"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        ...q["options"].map<Widget>((option) {
          return RadioListTile(
            title: Text(option),
            value: option,
            groupValue: answers[q["id"]],
            onChanged: (value) => onAnswer(q["id"], value),
          );
        }).toList(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSlider(Map<String, dynamic> q) {
    final value = (answers[q["id"]] ?? q["min"]).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          q["question"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Slider(
          min: q["min"].toDouble(),
          max: q["max"].toDouble(),
          divisions: q["max"] - q["min"],
          label: value.round().toString(),
          value: value,
          onChanged: (newValue) {
            onAnswer(q["id"], newValue.round());
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTextInput(Map<String, dynamic> q) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          q["question"],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: q["placeholder"],
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) => onAnswer(q["id"], value),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              json["title"],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(json["content"]),
          ],
        ),
      ),
    );
  }
}
