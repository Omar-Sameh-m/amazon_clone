import 'dart:developer';

import 'package:amazon_clone/layout/screen_layout.dart';
import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/views/results_screen.dart';
import 'package:amazon_clone/views/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCMBax2i83OUg8uSQYDQkhzBR3jO2ybOM8",
        authDomain: "clone-2c230.firebaseapp.com",
        projectId: "clone-2c230",
        storageBucket: "clone-2c230.firebasestorage.app",
        messagingSenderId: "101011406058",
        appId: "1:101011406058:web:b4854fdd0ec8be49b0eb93",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> user) {
          if (user.connectionState == ConnectionState.waiting) {
            log('loaded');
            return const Center(
              child: CircularProgressIndicator(color: yellowColor),
            );
          } else if (user.hasData) {
            return const ScreenLayout();
          } else {
            return const SignInScreen();
          }
        },
      ),
    );
  }
}
