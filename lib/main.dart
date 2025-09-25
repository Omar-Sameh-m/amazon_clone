import 'package:amazon_clone/blocs/user_details/user_details_bloc.dart';
import 'package:amazon_clone/layout/screen_layout.dart';
import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/views/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
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
  const AmazonClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserDetailsBloc>(
      create: (context) => UserDetailsBloc(),
      child: MaterialApp(
        title: "Amazon Clone",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> user) {
            if (user.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            } else if (user.hasData) {
              return const ScreenLayout();
            } else {
              return const SignInScreen();
            }
          },
        ),
      ),
    );
  }
}
