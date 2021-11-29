import 'dart:async';
import 'dart:math';
import 'package:chat/domain/models/chat_user.dart';
import 'package:chat/domain/models/chat_message.dart';
import 'package:chat/domain/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    // ChatMessage(
    //   id: '1',
    //   text: 'Bom dia',
    //   createdAt: DateTime.now(),
    //   userId: '123',
    //   userName: 'Alisson',
    //   userImageURL: 'assets/images/avatar.png',
    // ),
    // ChatMessage(
    //   id: '2',
    //   text: 'Opa, bom dia',
    //   createdAt: DateTime.now().add(const Duration(seconds: 5)),
    //   userId: '456',
    //   userName: 'Cristina',
    //   userImageURL: 'assets/images/avatar.png',
    // ),
    // ChatMessage(
    //   id: '3',
    //   text: 'Bom dia, pessoal',
    //   createdAt: DateTime.now().add(const Duration(seconds: 10)),
    //   userId: '789',
    //   userName: 'Bolete',
    //   userImageURL: 'assets/images/avatar.png',
    // ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final chatMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageURL,
    );

    _msgs.add(chatMessage);
    _controller?.add(_msgs.reversed.toList());
    return chatMessage;
  }
}
