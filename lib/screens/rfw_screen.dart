import 'package:flutter/material.dart';
import '../renderers/rfw_renderer.dart';

class RfwScreen extends StatelessWidget {
  const RfwScreen({super.key});

  static const String _library = '''
import core.widgets;

widget root = Directionality(
  textDirection: ltr,
  child: Center(
    child: Text(
      text: "Hello from RFW",
    ),
  ),
);
''';

  static const String _data = '''
{}
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RFW Only Demo')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: RfwRenderer(library: _library, data: _data),
      ),
    );
  }
}
