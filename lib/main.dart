import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/view/chat_pages.dart';
import 'package:scholar_chat/view/login_page.dart';
import 'package:scholar_chat/view/register_page.dart';
import 'package:scholar_chat/view/user_view_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        RegisterPage.id: (context) => const RegisterPage(),
        ChatPages.id: (context) =>  ChatPages(),
        UserViewPage.id: (context) => const UserViewPage(),
      },
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  ChatPages();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
