// import 'package:eco_feast/constants.dart';
// import 'package:eco_feast/screens/loginscreen.dart';
// import 'package:eco_feast/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants_ui.dart';
import 'login_screen.dart';
import 'signup_screen.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyDFuf0kG_oz1WZOoBYRKsRCh3op4Vnd_RI", appId: "", messagingSenderId: "405523211493", projectId: "merger-f28bb"));
  runApp(WelcomeScreen());
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageConstants.welcomeImage),
                  // Replace with your image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 180, right: 40, left: 40),
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: Text(
                  "Welcome to EcoFeast",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ), // Adjust the opacity as needed,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 280,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: ColorConstants.primaryColor,
                            foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 280,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            foregroundColor: ColorConstants.primaryColor,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 2, // thickness
                                    color: ColorConstants.primaryColor // color
                                ),
                                borderRadius: BorderRadius.circular(50))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen(uniqueID: "",Key: null,)),
                          );
                        },
                        child: const Text('Signup'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
