import 'package:flutter/material.dart';
import 'package:scholar_chat/view/login_page.dart';

class AdvancedAppBar extends AppBar {
  AdvancedAppBar({Key})
      : super(
            actions: [
              // IconButton(
              //   onPressed: () async {
              //     await messages.get().then((value) {
              //       for (var doc in value.docs) {
              //         doc.reference.delete();
              //       }
              //     });
              //   },
              //   icon: const Icon(Icons.delete, size: 28),
              // ),
              // IconButton(
              //   onPressed: () {
              //     _auth.signOut();
              //     Navigator.pushReplacementNamed(context, LoginPage.id);
              //   },
              //   icon: const Icon(Icons.logout, size: 28),
              // ),
            ],
            automaticallyImplyLeading: false,
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            // title: const Padding(
            //   padding: EdgeInsets.only(left: 20, bottom: 5),
            //   child: CircleAvatar(
            //     radius: 25,
            //     backgroundImage: AssetImage('assets/images/images.jpeg'),
            //   ),
            // ),
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 5),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/images.jpeg'),
                  ),
                ),
                Container(
                  child: Text('chat'),
                )
              ],
            ));
}
