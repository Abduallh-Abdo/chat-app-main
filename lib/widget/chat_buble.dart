import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/widget/constant.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(
          top: 32,
          left: 32,
          right: 32,
          bottom: 32,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.message,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              Constant().formatTime(date: message.time),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubleForFrind extends StatelessWidget {
  const ChatBubleForFrind({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(
          top: 32,
          left: 32,
          right: 32,
          bottom: 32,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.teal[800],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //  Text(
            //   FirebaseAuth.instance.currentUser!.updateDisplayName('')?? ,
            //   style: const TextStyle(color: Colors.white),
            // ),
            Text(
              message.message,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              Constant().formatTime(date: message.time),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
