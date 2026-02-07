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
      case "card":
        return _buildCard();
      default:
        return const Text("Unknown SDUI type");
    }
  }

  Widget _buildCard() {
    final iconText = json["icon"];
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
            if (iconText != null) ...[
              const SizedBox(height: 8),
              Text(iconText, style: const TextStyle(fontSize: 32)),
            ],
            const SizedBox(height: 8),
            Text(json["content"]),
          ],
        ),
      ),
    );
  }
}
