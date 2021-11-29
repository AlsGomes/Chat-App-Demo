import 'package:chat/components/message_balloon.dart';
import 'package:chat/domain/models/chat_message.dart';
import 'package:chat/domain/services/auth/auth_service.dart';
import 'package:chat/domain/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("Não há mensagens"),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (ctx, index) => MessageBalloon(
              key: ValueKey(msgs[index].id),
              chatMessage: msgs[index],
              belongsToCurrentUser: currentUser?.id == msgs[index].userId,
            ),
          );
        }
      },
    );
  }
}
