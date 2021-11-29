import 'dart:io';

import 'package:chat/domain/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBalloon extends StatelessWidget {
  static const _defaultUserImage = 'assets/images/avatar.png';
  final ChatMessage chatMessage;
  final bool belongsToCurrentUser;

  const MessageBalloon({
    Key? key,
    required this.chatMessage,
    required this.belongsToCurrentUser,
  }) : super(key: key);

  Widget _showUserImage(String userImageURL) {
    ImageProvider? provider;
    final uri = Uri.parse(userImageURL);

    if (uri.path.contains(_defaultUserImage)) {
      provider = const AssetImage(_defaultUserImage);
    } else if (uri.scheme.contains("http")) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              width: 180,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: belongsToCurrentUser
                      ? const Radius.circular(12)
                      : Radius.zero,
                  bottomRight: belongsToCurrentUser
                      ? Radius.zero
                      : const Radius.circular(12),
                ),
                color: belongsToCurrentUser
                    ? Colors.grey.shade300
                    : Theme.of(context).accentColor,
              ),
              child: Column(
                crossAxisAlignment: belongsToCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    chatMessage.userName,
                    style: TextStyle(
                      color: belongsToCurrentUser ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    chatMessage.text,
                    style: TextStyle(
                      color: belongsToCurrentUser ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? 115 : 0,
          right: belongsToCurrentUser ? 0 : 115,
          child: _showUserImage(chatMessage.userImageURL),
        )
      ],
    );
  }
}
