import 'dart:math';

import 'package:chat/components/messages.dart';
import 'package:chat/components/new_message.dart';
import 'package:chat/domain/models/chat_notification.dart';
import 'package:chat/domain/services/auth/auth_service.dart';
import 'package:chat/domain/services/notification/chat_notification_service.dart';
import 'package:chat/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gomes Chat"),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app, color: Colors.black87),
                      SizedBox(width: 10),
                      Text("Sair"),
                    ],
                  ),
                )
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.notificationPage),
                icon: const Icon(Icons.notifications),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.red.shade800,
                  maxRadius: 10,
                  child: Text(
                    Provider.of<ChatNotificationService>(context)
                        .itemsCount
                        .toString(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () => Provider.of<ChatNotificationService>(
      //     context,
      //     listen: false,
      //   ).add(
      //     ChatNotification(
      //       title: 'Notificação',
      //       body: Random().nextDouble().toString(),
      //     ),
      //   ),
      // ),
    );
  }
}
