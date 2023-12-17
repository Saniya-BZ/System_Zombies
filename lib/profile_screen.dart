// import 'package:flutter/material.dart';
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

//
// class ProfileScreen extends StatelessWidget {
//   final String userName = "John Doe";
//   final String userEmail = "john.doe@example.com";
//   final int userPoints = 1500;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Profile"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: CircleAvatar(
//                 radius: 50,
//                 child: Icon(Icons.person, size: 50),
//               ),
//             ),
//             SizedBox(height: 16),
//             ListTile(
//               title: Text(
//                 "Name: $userName",
//                 style: TextStyle(fontSize: 18),
//               ),
//               onTap: () {
//                 // Add functionality for editing the name
//               },
//             ),
//             Divider(),
//             ListTile(
//               title: Text(
//                 "Email: $userEmail",
//                 style: TextStyle(fontSize: 18),
//               ),
//               onTap: () {
//                 // Add functionality for editing the email
//               },
//             ),
//             Divider(),
//             ListTile(
//               title: Text(
//                 "Points: $userPoints",
//                 style: TextStyle(fontSize: 18),
//               ),
//               onTap: () {
//                 // Add functionality for viewing points details
//               },
//             ),
//             Divider(),
//             ListTile(
//               title: Text(
//                 "Settings",
//                 style: TextStyle(fontSize: 18),
//               ),
//               onTap: () {
//                 // Add functionality for Settings 1
//               },
//             ),
//             Divider(),
//             ListTile(
//               title: Text(
//                 "Logout",
//                 style: TextStyle(fontSize: 18, color: Colors.red),
//               ),
//               onTap: () {
//                 // Add functionality for logging out
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String uniqueID = "";

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchDataById() async {

    await getSharedPref();

    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
    await FirebaseFirestore.instance
        .collection(
        'allthedetails')
        .doc(uniqueID)
        .get();

    return documentSnapshot;
  }

  Future<void> getSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uniqueID = prefs.getString('UniqueID')!;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),

        child: SingleChildScrollView(
          child: Center(
            child: FutureBuilder<DocumentSnapshot>(
              future: fetchDataById(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  Map<String, dynamic>? myData =
                  snapshot.data?.data() as Map<String, dynamic>;
                  return
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('images/logo.png'),
                        ),
                        SizedBox(height: 20),
                        Text(
                          myData['name'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          myData['head'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20),

                        const Divider(),
                        SizedBox(height: 20),
                        Text('Your name'),
                        _buildInfoRow('Name', myData['name']),
                        _buildInfoRow('Email', myData['emp']),
                        _buildInfoRow('Points', '200 points'),


                        const Divider(),




                      ],
                    );
                }
              },
            ),


          ),
        ),
      ),
    );
  }
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

}
