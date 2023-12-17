
import 'package:flutter/material.dart';
import 'constants_ui.dart';

class OnboardingWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 160,
            color: ColorConstants.primaryColor,
          ),
          const SizedBox(height: 70.0),
          Text(
            title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: ColorConstants.primaryColor),
          ),
          const SizedBox(height: 8.0),
          Text(description,
            textAlign: TextAlign.center, style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black87),),
        ],
      ),
    );
  }
}