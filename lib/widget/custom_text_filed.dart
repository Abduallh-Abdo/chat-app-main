import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/widget/constant.dart';

// ignore: must_be_immutable
class CustomTextFiled extends StatelessWidget {
  CustomTextFiled(
      {super.key,
      required this.onSubmitted,
      required this.controller,
      required this.onPressed,
      required this.email});
  final Function(dynamic)? onSubmitted;
  final TextEditingController controller;
  final Function()? onPressed;
  final String email;

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: 'Send message',
          suffixIcon: IconButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                messages.add({
                  kMessage: controller.toString(),
                  kCreatedAt: DateTime.now(),
                  'id': email,
                  'message_time': DateTime.now().toString(),
                });
                controller.clear();
              }
            },
            icon: const Icon(
              Icons.send,
              color: Colors.teal,
            ),
          ),
          suffix: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 25,
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.teal,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.teal,
            ),
          ),
        ),
      ),
    );
  }
}
