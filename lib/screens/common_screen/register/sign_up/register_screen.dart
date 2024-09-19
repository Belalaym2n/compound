import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../utils/widgets.dart';
import '../widget_register.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  double screenHeight = 0;
  double screenWidth = 0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            showLogo(screenWidth: screenWidth, screenHeight: screenHeight),
            SizedBox(
              height: screenHeight / 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: screenWidth / 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTitle("Email", screenWidth),
                  SizedBox(
                    height: screenHeight / 70,
                  ),
                  customFormField(
                      hintText: "Enter your Email",
                      iconData: Icons.person,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      controller: emailController,
                      obscureText: false),
                  SizedBox(
                    height: screenHeight / 50,
                  ),
                  customTitle("Password", screenWidth),
                  SizedBox(
                    height: screenHeight / 70,
                  ),
                  customFormField(
                      hintText: "Enter your password",
                      iconData: Icons.lock,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      controller: passwordController,
                      obscureText: true),
                  SizedBox(
                    height: screenHeight / 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: "codiaadvscg@gamil.com",
                        password: "password",
                      );
                    },
                    // Clear the text fields

                    child: const Text("Register"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _registerTestUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: "belalscg@gmail.com", password: "SuperSecretPassword!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
