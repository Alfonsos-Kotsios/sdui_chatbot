import 'package:flutter/material.dart';
import '../backend/mock_backend.dart';
import '../models.dart';
import '../renderers/sdui_renderer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final Map<String, dynamic> _answers = {};
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messages.add(
      ChatMessage(
        id: 'bot-1',
        isUser: false,
        text:
            'Γεια σου! Γράψε το αίτημά σου (π.χ. «καιρός»,'
            ') και θα λάβεις δυναμικό UI.',
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addUserMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      return;
    }

    setState(() {
      _messages.add(
        ChatMessage(
          id: 'user-${DateTime.now().millisecondsSinceEpoch}',
          isUser: true,
          text: trimmed,
        ),
      );

      _answers.clear();
      _messages.add(
        ChatMessage(
          id: 'bot-${DateTime.now().millisecondsSinceEpoch}',
          isUser: false,
          sduiJson: MockBackend.handleUserMessage(trimmed),
        ),
      );
    });

    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SDUI Chatbot Demo')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isLastMessage = index == _messages.length - 1;

                return _ChatBubble(
                  message: message,
                  isInteractive: isLastMessage && message.sduiJson != null,
                  answers: _answers,
                  onAnswer: (id, value) {
                    setState(() {
                      _answers[id] = value;
                    });
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          _ChatInput(controller: _controller, onSend: _addUserMessage),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isInteractive;
  final Map<String, dynamic> answers;
  final Function(String, dynamic) onAnswer;

  const _ChatBubble({
    required this.message,
    required this.isInteractive,
    required this.answers,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final alignment = message.isUser
        ? Alignment.centerRight
        : Alignment.centerLeft;
    final bubbleColor = message.isUser
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.surfaceVariant;
    final textColor = message.isUser
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 360),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: message.sduiJson != null
            ? SDUIRenderer(
                json: message.sduiJson!,
                answers: isInteractive ? answers : const {},
                onAnswer: isInteractive ? onAnswer : (_, __) {},
              )
            : Text(message.text ?? '', style: TextStyle(color: textColor)),
      ),
    );
  }
}

class _ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSend;

  const _ChatInput({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Γράψε κάτι... (π.χ. καιρός)',
                border: OutlineInputBorder(),
              ),
              onSubmitted: onSend,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => onSend(controller.text),
          ),
        ],
      ),
    );
  }
}
