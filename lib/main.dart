import 'package:amazon_clone/blocs/auth/auth_state.dart';
import 'package:amazon_clone/layout/screen_layout.dart';
import 'package:amazon_clone/repositories/auth_repository.dart';
import 'package:amazon_clone/repositories/product_repository.dart';
import 'package:amazon_clone/blocs/auth/auth_cubit.dart';
import 'package:amazon_clone/blocs/product/product_cubit.dart';
import 'package:amazon_clone/blocs/cart/cart_cubit.dart';
import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/views/sign_in_screen.dart';
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
  const AmazonClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => ProductRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthCubit(context.read<AuthRepository>())..checkAuthStatus(),
          ),
          BlocProvider(
            create: (context) =>
                ProductCubit(context.read<ProductRepository>()),
          ),
          BlocProvider(create: (_) => CartCubit()),
        ],
        child: MaterialApp(
          title: 'Amazon Clone',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: backgroundColor,
          ),
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: yellowColor),
                );
              } else if (state is AuthAuthenticated) {
                return const ScreenLayout();
              } else {
                return const SignInScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
