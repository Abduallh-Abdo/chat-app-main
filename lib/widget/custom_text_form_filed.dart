import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormFileed extends StatelessWidget {
  CustomTextFormFileed(
      {super.key,
      required this.text,
      this.onchange,
      this.obscureText = false,
      required this.prefix,
      required this.textcontroller,
      this.onSaved});
  final String text;
  Function(String)? onchange;
  void Function(String?)? onSaved;
  bool? obscureText;
  Widget prefix;
  final TextEditingController textcontroller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'filed is required';
        }
        return null;
      },
      controller: textcontroller,
      onChanged: onchange,
      onSaved: onSaved,
      decoration: InputDecoration(
        prefixIcon: prefix,
        hintText: text,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
