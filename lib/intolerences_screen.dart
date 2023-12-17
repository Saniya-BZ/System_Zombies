import 'all_screens.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants_ui.dart';

class IntolerancesPreferenceScreen extends StatefulWidget {
  const IntolerancesPreferenceScreen({super.key});

  @override
  State<IntolerancesPreferenceScreen> createState() => _IntolerancesPreferenceScreenState();
}

class _IntolerancesPreferenceScreenState extends State<IntolerancesPreferenceScreen> {

  List<String> intoleranceType = [
    'Dairy',
    'Egg',
    'Gluten',
    'Grain',
    'Peanut',
    'Seafood',
    'Sesame',
    'Shellfish',
    'Soy',
    'Sulfite',
    'Tree Nut',
    'Wheat',
  ];


  String selectedIntolerances = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              const Text(
                "Diet Preference (Intolerances)",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
              SizedBox(
                height: 40,
              ),
              Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: intoleranceType.length,
                  itemBuilder: (context, index) {
                    final dietType = intoleranceType[index];
                    return CheckboxListTile(
                      title: Text(dietType),
                      value: selectedIntolerances.contains(dietType),
                      onChanged: (value) {
                        setState(() {
                          if (value!) {
                            // Add cuisine to the selectedCuisines string
                            selectedIntolerances +=
                                (selectedIntolerances.isEmpty ? '' : ', ') + dietType;
                          } else {
                            // Remove cuisine from the selectedCuisines string
                            selectedIntolerances = selectedIntolerances
                                .replaceAll(', $dietType', '')
                                .replaceAll('$dietType, ', '');
                            selectedIntolerances =
                                selectedIntolerances.replaceAll(dietType, '');
                          }
                        });
                      },
                    );
                  },
                ),
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
                    onPressed: () async {
                      if (selectedIntolerances.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                          Text("Select any diet preference to continue"),
                          duration: Duration(seconds: 1),
                        ));
                      } else {
                        final sharedPref =  await SharedPreferences.getInstance();
                        sharedPref.setString("Intolerance", selectedIntolerances);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                        );
                      }
                    },
                    child: const Text(
                      'Proceed',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}