import 'dart:io';

import 'package:flutter/material.dart';

const kPrimrayColor = Color(0xff2B475E);
const kLogo = 'assets/images/scholar.png';
const kMessagesCollection = 'messages';
const kMessage = 'message';
const kCreatedAt = 'createdAt';
File? image;
//
//const kId='id';

class Constant {
  String formatTime({required String date}) {
    // String dateTimeString = ;

    List<String> parts = date.split(' ');
    String timePart = parts[1];
    List<String> timeComponents = timePart.split(':');
    String hours =
        (int.parse(timeComponents[0]) + 1).toString().padLeft(2, '0');
    String minutes = timeComponents[1];

    return '$hours:$minutes';
  }
}

class Images {
  void imagePick({required File imagepicked}) {
    image = imagepicked;
  }
}
