import 'package:chat/domain/services/notification/chat_notification_service.dart';
import 'package:chat/pages/auth_or_app_page.dart';
import 'package:chat/pages/notification_page.dart';
import 'package:chat/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ChatNotificationService(),
        )
      ],
      child: MaterialApp(
        title: 'Chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.homePage: (ctx) => const AuthOrAppPage(),
          AppRoutes.notificationPage: (ctx) => const NotificationPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
