
import 'intolerences_screen.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants_ui.dart';

class DietPreferenceScreen extends StatefulWidget {
  const DietPreferenceScreen({super.key});

  @override
  State<DietPreferenceScreen> createState() => _DietPreferenceScreenState();
}

class _DietPreferenceScreenState extends State<DietPreferenceScreen> {
  List<String> dietTypes = [
    'Gluten-Free',
    'Ketogenic',
    'Vegetarian',
    'Vegan',
    'Primal',
    'Low FODMAP',
    'Whole30',
  ];

  String selectedDiets = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              const Text(
                "Diet Preference",
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
                  itemCount: dietTypes.length,
                  itemBuilder: (context, index) {
                    final dietType = dietTypes[index];
                    return CheckboxListTile(
                      title: Text(dietType),
                      value: selectedDiets.contains(dietType),
                      onChanged: (value) {
                        setState(() {
                          if (value!) {

                            selectedDiets +=
                                (selectedDiets.isEmpty ? '' : ', ') + dietType;
                          } else {
                            selectedDiets = selectedDiets
                                .replaceAll(', $dietType', '')
                                .replaceAll('$dietType, ', '');
                            selectedDiets =
                                selectedDiets.replaceAll(dietType, '');
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
                      if (selectedDiets.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                          Text("Select any diet preference to continue"),
                          duration: Duration(seconds: 1),
                        ));
                      } else {
                        final sharedPref =  await SharedPreferences.getInstance();
                        sharedPref.setString("Diet", selectedDiets);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IntolerancesPreferenceScreen()),
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
