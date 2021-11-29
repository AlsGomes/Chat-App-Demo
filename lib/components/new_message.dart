import 'package:chat/domain/services/auth/auth_service.dart';
import 'package:chat/domain/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      await ChatService().save(_enteredMessage, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onSubmitted: (_) {
              if (_enteredMessage.isNotEmpty) {
                _sendMessage();
              }
            },
            controller: _messageController,
            onChanged: (msg) => setState(() => _enteredMessage = msg),
            decoration: const InputDecoration(
              labelText: "Enviar mensagem...",
            ),
          ),
        ),
        IconButton(
          onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          icon: const Icon(Icons.send),
        )
      ],
    );
  }
}
