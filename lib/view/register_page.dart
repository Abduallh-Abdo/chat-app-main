import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:scholar_chat/view/chat_pages.dart';
import 'package:scholar_chat/widget/constant.dart';

import 'package:scholar_chat/widget/custom_Button.dart';
import 'package:scholar_chat/widget/custom_text_form_filed.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });
  static String id = 'register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();
  bool isLoading = false;
  File? _image; // Store the picked image

  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeFirebase(); // Initialize Firebase on startup
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    log("Firebase initialized");
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  String imageUrl = '';
  Future<void> signUp() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty) {
      _showSnackBar("Please fill in all fields.");
      return;
    }

    if (_image == null) {
      _showSnackBar("Please select a profile photo.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        // Upload the image to Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${user.uid}.jpg');
        await storageRef.putFile(_image!);

        // Get the download URL for the uploaded image
        imageUrl = await storageRef.getDownloadURL();

        // Save the user info in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'email': emailController.text.trim(),
          'name': nameController.text.trim(),
          'imageUrl': imageUrl,
        });

        log("User signed up: ${user.email}");
        _showSnackBar("Sign-up successful.");

        // Navigate to the login page after successful signup
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ChatPages(
              name: nameController.text.isNotEmpty
                  ? nameController.text.trim()
                  : 'Guset',
              image: _image,
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Email is already in use.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'weak-password':
          errorMessage = 'Password is too weak.';
          break;
        default:
          errorMessage = 'Sign-up failed. Please try again.';
      }
      _showSnackBar(errorMessage);
    } catch (e) {
      log("Error: $e");
      _showSnackBar("Sign-up failed. Please try again.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
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
                  const SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: (_image != null)
                          ? FileImage(_image!)
                          : const AssetImage('assets/images/add.jpg')
                              as ImageProvider,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'New User',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextFormFileed(
                    textcontroller: nameController,
                    prefix: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    text: 'name',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormFileed(
                    textcontroller: emailController,
                    prefix: const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    text: 'Email',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormFileed(
                    textcontroller: passwordController,
                    prefix: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    onSaved: (p0) {
                      if (formKey.currentState!.validate()) {
                        signUp();
                      }
                    },
                    text: 'Password',
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  CustomContaier(
                    alignment: Alignment.center,
                    color: Colors.white,
                    onTap: signUp,
                    title: 'Sgin Up',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'already have account?',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          '   Login',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 18,
                          ),
                        ),
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

  Future<void> registerUser({
    required Future<void> Function(String uid) onSuccess,
    required String? email,
    required String? password,
    required String? name,
  }) async {
    if (email == null || password == null) {
      throw ArgumentError('Email and password must not be null.');
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // await FirebaseAuth.instance.currentUser!
      //     .updateDisplayName(nameController.text);

      User? user = userCredential.user;

      if (user != null) {
        // Execute callback for successful signup
        await onSuccess(user.uid);
      }
    } catch (e) {
      // Handle exceptions (e.g., show error message to the user)
      print('Registration failed: $e');
    }
  }
}
