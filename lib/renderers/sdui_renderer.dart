import 'package:flutter/material.dart';
import 'package:rfw/rfw.dart';
import '../rfw/rfw_runtime.dart';

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
      case "rfw_card":
        return RfwCardRenderer(
          data: Map<String, dynamic>.from(json["data"] as Map),
        );
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

class RfwCardRenderer extends StatefulWidget {
  final Map<String, dynamic> data;

  const RfwCardRenderer({super.key, required this.data});

  @override
  State<RfwCardRenderer> createState() => _RfwCardRendererState();
}

class _RfwCardRendererState extends State<RfwCardRenderer> {
  final RfwRuntime _runtime = RfwRuntime();

  @override
  void initState() {
    super.initState();
    _updateRuntimeData(widget.data);
  }

  @override
  void didUpdateWidget(covariant RfwCardRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _updateRuntimeData(widget.data);
    }
  }

  void _updateRuntimeData(Map<String, dynamic> data) {
    _runtime.updateData(<String, Object?>{
      'title': data['title'] ?? '',
      'content': data['content'] ?? '',
      'icon': data['icon'] ?? '',
      'subtitle': '',
    });
  }

  @override
  Widget build(BuildContext context) {
    return RemoteWidget(
      runtime: _runtime.runtime,
      data: _runtime.data,
      widget: _runtime.cardWidget,
    );
  }
}
