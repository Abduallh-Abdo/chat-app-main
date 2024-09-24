// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:scholar_chat/models/message.dart';
// import 'package:scholar_chat/view/login_page.dart';
// import 'package:scholar_chat/widget/chat_buble.dart';
// import 'package:scholar_chat/widget/constant.dart';
// import 'package:scholar_chat/widget/custom_text_filed.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatPages extends StatefulWidget {
//   static String id = 'ChatPages';

//   @override
//   State<ChatPages> createState() => _ChatPagesState();
// }

// class _ChatPagesState extends State<ChatPages> {
//   CollectionReference messages =
//       FirebaseFirestore.instance.collection(kMessagesCollection);

//   TextEditingController controller = TextEditingController();

//   ScrollController scrollController = ScrollController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final ImagePicker _imagePicker = ImagePicker();

//   File? _image;
//   bool _isloading = false;
//   @override
//   void initState() {
//     _initializeFirebase(); // Initialize Firebase on startup
//     super.initState();
//   }

//   Future<void> _initializeFirebase() async {
//     await Firebase.initializeApp();
//     print("Firebase initialized");
//   }

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await _imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var email = FirebaseAuth.instance.currentUser!.email;
//     // var email = ModalRoute.of(context)!.settings.arguments;
//     return StreamBuilder<QuerySnapshot>(
//         stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<Message> messageList = [];
//             for (int i = 0; i < snapshot.data!.docs.length; i++) {
//               messageList.add(Message.formJson(snapshot.data!.docs[i]));
//             }

//             return Scaffold(
//               appBar: AppBar(
//                 actions: [
//                   IconButton(
//                     onPressed: () {
//                       FirebaseFirestore.instance
//                           .collection(kMessagesCollection)
//                           .get()
//                           .then((value) {
//                         for (var doc in value.docs) {
//                           doc.reference.delete();
//                         }
//                       });
//                     },
//                     icon: const Icon(
//                       Icons.delete,
//                       size: 28,
//                     ),
//                   ),
//                   IconButton(
//                       onPressed: () {
//                         FirebaseAuth.instance.signOut();
//                         Navigator.pushReplacementNamed(context, LoginPage.id);
//                       },
//                       icon: const Icon(
//                         Icons.logout,
//                         size: 28,
//                       )),
//                 ],
//                 leading: const Icon(
//                   Icons.arrow_back,
//                   size: 28,
//                 ),
//                 //automaticallyImplyLeading: false,
//                 backgroundColor: Colors.teal,
//                 foregroundColor: Colors.white,
//                 title: const CircleAvatar(
//                   radius: 25,
//                   backgroundImage: AssetImage(
//                     'assets/images/images.jpeg',
//                     //height: 50,
//                   ),
//                 ),
//               ),
//               body: Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                         reverse: true,
//                         controller: scrollController,
//                         itemCount: messageList.length,
//                         itemBuilder: (context, index) {
//                           return messageList[index].id == email
//                               ? ChatBuble(
//                                   message: messageList[index],
//                                 )
//                               : ChatBubleForFrind(message: messageList[index]);
//                         }),
//                   ),
//                   CustomTextFiled(
//                     onPressed: _pickImage,
//                     email: email.toString(),
//                     controller: controller,
//                     onSubmitted: (data) {
//                       messages.add({
//                         kMessage: data,
//                         kCreatedAt: DateTime.now(),
//                         'id': email,
//                         'message_time': DateTime.now().toString(),
//                         // 'name':
//                       });
//                       controller.clear();
//                       scrollController.animateTo(
//                         0,
//                         curve: Curves.easeOut,
//                         duration: const Duration(microseconds: 500),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return const Scaffold(
//               body: Center(
//                 child: Text(
//                   'loading',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 32,
//                   ),
//                 ),
//               ),
//             );
//           }
//         });
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/view/login_page.dart';
import 'package:scholar_chat/widget/chat_buble.dart';
import 'package:scholar_chat/widget/constant.dart';
import 'package:scholar_chat/widget/custom_text_filed.dart';

// ignore: must_be_immutable
class ChatPages extends StatefulWidget {
  static String id = 'ChatPages';
  String? name;
  dynamic image;

  ChatPages({
    super.key,
    this.name,
    this.image,
  });

  @override
  State<ChatPages> createState() => _ChatPagesState();
}

class _ChatPagesState extends State<ChatPages> {
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var email = _auth.currentUser?.email;

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Error loading messages"));
        }

        if (snapshot.hasData) {
          List<Message> messageList =
              snapshot.data!.docs.map((doc) => Message.formJson(doc)).toList();

          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () async {
                    await messages.get().then((value) {
                      for (var doc in value.docs) {
                        doc.reference.delete();
                      }
                    });
                  },
                  icon: const Icon(Icons.delete, size: 28),
                ),
                IconButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushReplacementNamed(context, LoginPage.id);
                  },
                  icon: const Icon(Icons.logout, size: 28),
                ),
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              title: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 5),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: widget.image is String
                        ? NetworkImage(widget.image as String) // If it's a URL
                        : widget.image is File
                            ? FileImage(widget.image as File) // If it's a File
                            : const AssetImage('assets/images/images.jpeg')
                                as ImageProvider, // Default asset image
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  widget.name.toString(),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.of(context).pushNamed(UserViewPage.id);
                //   },
                //   child: const Text(''),
                // ),
              ]),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBuble(message: messageList[index])
                          : ChatBubleForFrind(
                              message: messageList[index],
                            );
                    },
                  ),
                ),
                CustomTextFiled(
                  onPressed: () {},
                  email: email ?? '',
                  controller: controller,
                  onSubmitted: (data) {
                    messages.add({
                      kMessage: data,
                      kCreatedAt: DateTime.now(),
                      'id': email,
                      'message_time': DateTime.now().toString(),
                    });
                    controller.clear();
                    scrollController.animateTo(
                      0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No messages found.'));
        }
      },
    );
  }
}
