// ignore_for_file: use_build_context_synchronously

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:scholar_chat/helper/show_snak_bar.dart';
// import 'package:scholar_chat/view/chat_pages.dart';
// import 'package:scholar_chat/view/register_page.dart';
// import 'package:scholar_chat/widget/custom_Button.dart';
// import 'package:scholar_chat/widget/custom_text_form_filed.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//   static String id = 'LoginPage';

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool isLoading = false;

//   GlobalKey<FormState> formKey = GlobalKey();
//   String? email, password;
//   final TextEditingController emailcontroller = TextEditingController();
//   final TextEditingController passowardcontroller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return ModalProgressHUD(
//       inAsyncCall: isLoading,
//       child: Scaffold(
//         backgroundColor: Colors.teal,
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: SingleChildScrollView(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 70,
//                   ),
//                   const CircleAvatar(
//                     radius: 70,
//                     backgroundImage: AssetImage(
//                         'assets/images/WhatsApp Image 2024-09-22 at 23.34.54_f87c742d.jpg'),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   const Text(
//                     'Welcome ',
//                     style: TextStyle(
//                       fontFamily: 'Pacifico',
//                       fontSize: 32,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   CustomTextFormFileed(
//                     textcontroller: emailcontroller,
//                     prefix: const Icon(
//                       Icons.email,
//                       color: Colors.white,
//                     ),
//                     onchange: (data) {
//                       email = data;
//                     },
//                     text: 'Email',
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   CustomTextFormFileed(
//                     textcontroller: passowardcontroller,
//                     prefix: const Icon(
//                       Icons.lock_sharp,
//                       color: Colors.white,
//                     ),
//                     obscureText: true,
//                     onchange: (data) {
//                       password = data;
//                     },
//                     text: 'Password',
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   // const Padding(
//                   //   padding: EdgeInsets.only(right: 15),
//                   //   child: Align(
//                   //     alignment: Alignment.centerRight,
//                   //     child: Text(
//                   //       'Forget Password ? ',
//                   //       style: TextStyle(color: Colors.white, fontSize: 20),
//                   //     ),
//                   //   ),
//                   // ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   CustomContaier(
//                     onTap: () async {
//                       if (formKey.currentState!.validate()) {
//                         isLoading = true;
//                         setState(() {});
//                         try {
//                           await loginUser();
//                           Navigator.pushNamed(context, ChatPages.id,
//                               arguments: email);
//                         } on FirebaseAuthException catch (ex) {
//                           if (ex.code == 'user_ not_found') {
//                             showSnackBar(context, 'weak password');
//                           } else if (ex.code == 'wrong_password') {
//                             showSnackBar(context, 'worng password');
//                           }
//                         } catch (ex) {
//                           showSnackBar(context, 'there was an error');
//                         }
//                         isLoading = false;
//                         setState(() {});
//                       }
//                     },
//                     title: 'LOGIN',
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'don\'t have an account?',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, RegisterPage.id);
//                         },
//                         child: const Text(
//                           '   Sign up',
//                           style: TextStyle(color: Colors.purple, fontSize: 18),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> loginUser() async {
//     await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email!,
//       password: password!,
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/helper/show_snak_bar.dart';
import 'package:scholar_chat/view/chat_pages.dart';
import 'package:scholar_chat/view/register_page.dart';
import 'package:scholar_chat/widget/custom_Button.dart';
import 'package:scholar_chat/widget/custom_text_form_filed.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  // Login handler method
  void handleLogin() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        // Authenticate user with Firebase
        await loginUser();

        // Get the current user's ID from FirebaseAuth
        String? userId = FirebaseAuth.instance.currentUser?.uid;

        if (userId != null) {
          // Fetch user data from Firestore based on the UID
          DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();

          if (userSnapshot.exists) {
            // Extract user details from Firestore
            String username = userSnapshot['name'] ?? 'Guest';
            String? imageUrl = userSnapshot[
                'imageUrl']; // Assuming imageUrl is stored in Firestore

            // Navigate to HomeScreen (or ChatPage) with user details
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPages(
                  name: username,

                  image:
                      imageUrl ?? '', // Pass empty string if imageUrl is null
                ),
              ),
            );
          } else {
            // Handle the case where user data doesn't exist in Firestore
            showSnackBar(context, 'User data not found!');
          }
        } else {
          // Handle the case where no user ID was retrieved
          showSnackBar(context, 'Unable to fetch user data!');
        }
      } on FirebaseAuthException catch (ex) {
        // FirebaseAuthException: Handle specific login errors
        String message;
        switch (ex.code) {
          case 'user-not-found':
            message = 'No user found for that email.';
            break;
          case 'wrong-password':
            message = 'Incorrect password.';
            break;
          default:
            message = 'An error occurred. Please try again.';
        }
        showSnackBar(context, message);
      } catch (ex) {
        // Handle any other errors (non-FirebaseAuth related)
        showSnackBar(
            context, 'An unexpected error occurred. Please try again.');
      } finally {
        // Reset loading state
        setState(() {
          isLoading = false;
        });
      }
    }
  }

// Navigate and finish method for screen transitions
  void navigateAndFinish({
    required BuildContext context,
    required Widget widget,
  }) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 70),
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(
                        'assets/images/WhatsApp Image 2024-09-22 at 23.34.54_f87c742d.jpg'),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormFileed(
                    textcontroller: emailController,
                    prefix: const Icon(Icons.email, color: Colors.white),
                    text: 'Email',
                    onchange: (data) {},
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormFileed(
                    textcontroller: passwordController,
                    prefix: const Icon(Icons.lock_sharp, color: Colors.white),
                    obscureText: true,
                    text: 'Password',
                    onchange: (data) {},
                  ),
                  const SizedBox(height: 30),
                  CustomContaier(
                    onTap: handleLogin,
                    title: 'LOGIN',
                    color: Colors.white,
                    alignment: Alignment.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('don\'t have an account?',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text('   Sign up',
                            style:
                                TextStyle(color: Colors.purple, fontSize: 18)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
