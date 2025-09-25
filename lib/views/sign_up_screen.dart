import 'package:amazon_clone/resources/auth_methods.dart';
import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/views/sign_in_screen.dart';
import 'package:amazon_clone/widgets/custom_main_button.dart';
import 'package:amazon_clone/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthMethods authMethods = AuthMethods();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                  SizedBox(
                    height: screenSize.height * 0.7,
                    child: FittedBox(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        height: screenSize.height * 0.85,
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
                              'Sign-Up',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 33,
                              ),
                            ),
                            TextFieldWidget(
                              title: 'Name',
                              hintText: 'Enter Your Name',
                              controller: nameController,
                              obscureText: false,
                            ),
                            TextFieldWidget(
                              title: 'Adress',
                              hintText: 'Enter Your Address',
                              controller: addressController,
                              obscureText: false,
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
                                String output = await authMethods.signUpUser(
                                  name: nameController.text,
                                  address: addressController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                if (output == 'Success') {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SignInScreen();
                                      },
                                    ),
                                  );
                                } else {
                                  Utils().showSnackBar(
                                    context: context,
                                    content: output,
                                  );
                                }
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  CustomMainButton(
                    color: Colors.grey[400]!,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignInScreen();
                          },
                        ),
                      );
                    },
                    child: Text('Back', style: TextStyle(color: Colors.black)),
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
