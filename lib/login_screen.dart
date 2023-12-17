// import 'package:eco_feast/constants.dart';
// import 'package:eco_feast/screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'constants_ui.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome Back",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
            const Text(
              "Please enter your details",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email or UserName',
                hintText: 'Enter Your Email or UserName',
              ),
            ),
            SizedBox(
              height: 34,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter Your Password',
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: SizedBox(
                width: 240,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorConstants.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const LoginScreen()),
                    // );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'New user? ',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Create Account',
                        style: TextStyle(
                            color: ColorConstants.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        recognizer: TapGestureRecognizer()..onTap = (){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen(uniqueID: "",Key: null,)),
                          );
                        }
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}