import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'diet_preference_screen.dart';
import 'login_screen.dart';
import 'constants_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SignupScreen extends StatefulWidget {
  final String uniqueID;
  const SignupScreen({super.key, required this.uniqueID, required Key});

  @override
  State<SignupScreen> createState() => _SignupScreenState(uniqueID: uniqueID);
}

class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final String uniqueID;
  _SignupScreenState({required this.uniqueID});
  Future<DocumentSnapshot<Map<String,dynamic>>> fetchDataById(String documentId) async {
    DocumentSnapshot<
        Map<String, dynamic>> documentSnapshot = await FirebaseFirestore
        .instance
        .collection(
        'allthedetails')
        .doc(documentId)
        .get();

    return documentSnapshot;
  }
  void initState(){
    super.initState();
    fetchDataById(uniqueID);
  }

  void saveProfile() async{

    String name = nameController.text;
    String email = emailController.text;
    
    try {
      String resp = await StoreData().saveData(name: name, email: email);
      if(resp.isNotEmpty)
      {

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('UniqueID', resp);
        
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const DietPreferenceScreen()),
        );

      }

    }
    catch(e)
    {
      print("error : $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome!",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
                const Text(
                  "Please enter your details to signup",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'UserName',
                    hintText: 'Enter Your UserName',
                  ),
                ),
                SizedBox(
                  height: 34,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                    hintText: 'Enter Your Email Address',
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
                  height: 34,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Passowrd',
                    hintText: 'Enter Password Again To Confirm',
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
                        saveProfile();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const DietPreferenceScreen()),
                        // );
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                      text: 'Already created account? ',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Login',
                            style: TextStyle(
                                color: ColorConstants.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const LoginScreen()),
                                );
                              }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData({
    required String name,
    required String email,

  }) async {
    String resp = "";
    try {
      if (name.isNotEmpty || email.isNotEmpty) {
        // String imageUrl = await uploadImageToStorage('profileImage', file);
        DocumentReference<Map<String, dynamic>> documentReference =
        await _firestore.collection('allthedetails').add({
          'name': name,
          'bio': email,

        });


        resp = documentReference.id;

        return resp;
      }
    } catch (err) {
      return '';
    }
    return resp;
  }
}
