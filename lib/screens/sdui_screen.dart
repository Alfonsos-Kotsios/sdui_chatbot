import 'package:flutter/material.dart';
import '../jsons/initial_questionnaire.dart';
import '../renderers/sdui_renderer.dart';
import '../backend/mock_backend.dart';

class SDUIScreen extends StatefulWidget {
  const SDUIScreen({super.key});

  @override
  State<SDUIScreen> createState() => _SDUIScreenState();
}

class _SDUIScreenState extends State<SDUIScreen> {
  final Map<String, dynamic> answers = {};
  Map<String, dynamic> currentJson = initialQuestionnaire;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SDUI Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SDUIRenderer(
          json: currentJson,
          answers: answers,
          onAnswer: (id, value) {
            setState(() {
              answers[id] = value;
            });
          },
          onSubmit: handleSubmit,
        ),
      ),
    );
  }

  void handleSubmit() {
    final responseJson = MockBackend.sendAnswers(answers);

    setState(() {
      answers.clear(); // reset για το επόμενο UI
      currentJson = responseJson;
    });
  }
}
