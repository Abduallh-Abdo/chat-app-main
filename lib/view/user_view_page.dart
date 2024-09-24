import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/widget/constant.dart';


class UserViewPage extends StatefulWidget {
  const UserViewPage({super.key});
  static String id = 'UserViewPage';

  @override
  State<UserViewPage> createState() => _UserViewPageState();
}

class _UserViewPageState extends State<UserViewPage> {
  //  final CollectionReference userInfo =
  //     FirebaseFirestore.instance.collection('UserInfo');
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.only(left: 20, bottom: 5),
          child: Text(
            'Setting',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: const Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 100,
            // ),
            // CustomContaier(
            //   alignment: Alignment.centerLeft,
            //   title: '    ujhuu',
            //   color: Colors.teal,
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // CustomContaier(
            //   alignment: Alignment.centerLeft,
            //   title: '    ujhuu',
            //   color: Colors.teal,
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // CustomContaier(
            //   alignment: Alignment.centerLeft,
            //   title: '    ujhuu',
            //   color: Colors.teal,
            // ),
          ],
        ),
      ),
    );
  }
}
