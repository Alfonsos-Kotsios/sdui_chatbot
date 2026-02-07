import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'rfw_demo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SDUI Chatbot Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _NavCard(
            title: 'Chat SDUI',
            subtitle: 'Δοκιμή του υπάρχοντος SDUI chatbot.',
            icon: Icons.chat_bubble_outline,
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ChatScreen()));
            },
          ),
          const SizedBox(height: 40),
          _NavCard(
            title: 'RFW Παράδειγμα',
            subtitle: 'Πρώτο βήμα για Remote Flutter Widgets αρχιτεκτονική.',
            icon: Icons.widgets_outlined,
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const RfwDemoScreen()));
            },
          ),
        ],
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _NavCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
