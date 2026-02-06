import 'package:flutter/material.dart';
import 'package:rfw/rfw.dart';
import '../rfw/rfw_runtime.dart';

class RfwDemoScreen extends StatefulWidget {
  const RfwDemoScreen({super.key});

  @override
  State<RfwDemoScreen> createState() => _RfwDemoScreenState();
}

class _RfwDemoScreenState extends State<RfwDemoScreen> {
  final RfwRuntime _rfwRuntime = RfwRuntime();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RFW Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Παράδειγμα Remote Flutter Widgets (RFW) με runtime, library και data.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            child: RemoteWidget(
              runtime: _rfwRuntime.runtime,
              data: _rfwRuntime.data,
              widget: _rfwRuntime.rootWidget,
            ),
          ),
        ],
      ),
    );
  }
}
