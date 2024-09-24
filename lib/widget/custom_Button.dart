import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomContaier extends StatelessWidget {
  const CustomContaier(
      {super.key,
      required this.title,
      this.onTap,
      required this.color,
      required this.alignment});
  final String title;
  final VoidCallback? onTap;
  final Color color;
  final Alignment alignment;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: alignment,
        width: 200,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 42, 99, 147),
            //color: Colors.blue
          ),
        ),
      ),
    );
  }
}
