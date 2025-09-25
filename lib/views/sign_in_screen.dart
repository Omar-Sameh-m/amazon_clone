import 'package:amazon_clone/resources/auth_methods.dart';
import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/views/sign_up_screen.dart';
import 'package:amazon_clone/widgets/custom_main_button.dart';
import 'package:amazon_clone/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 10,
                vertical: 20,
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(amazonLogo, height: screenSize.height * 0.10),
                  Container(
                    padding: EdgeInsets.all(15),
                    height: screenSize.height * 0.6,
                    width: screenSize.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Text(
                          'Sign-in',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 33,
                          ),
                        ),
                        TextFieldWidget(
                          title: 'Email',
                          hintText: 'Enter Your Email',
                          controller: emailController,
                          obscureText: false,
                        ),
                        TextFieldWidget(
                          title: 'Password',
                          hintText: 'Enter Your password',
                          controller: passwordController,
                          obscureText: true,
                        ),
                        CustomMainButton(
                          color: yellowColor,
                          isLoading: isLoading,
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            String output = await AuthMethods().signInUser(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            setState(() {
                              isLoading = false;
                            });
                            if (output == 'success') {
                              setState(() {});
                            } else {
                              Utils().showSnackBar(
                                context: context,
                                content: output,
                              );
                            }
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Container(height: 1, color: Colors.grey)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('New to Amazon ?'),
                      ),
                      Expanded(child: Container(height: 1, color: Colors.grey)),
                    ],
                  ),
                  CustomMainButton(
                    color: Colors.grey[400]!,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignUpScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Crate an Amazon account',
                      style: TextStyle(color: Colors.black),
                    ),
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
