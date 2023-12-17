import 'package:flutter/material.dart';


class TipsScreen extends StatelessWidget {
  final List<String> tips = [
    "Local and Seasonal Ingredients",
    "Reduce Meat Consumption",
    "Mindful Meal Planning",
    "Energy-Efficient Appliances",
    "Reusable and Eco-friendly Cookware",
    "Water Conservation",
    "Composting",
    "Reusable Utensils and Dishware",
    "Bulk Buying",
    "DIY Condiments and Sauces",
    "Canning and Preserving",
    "Choose Eco-friendly Cleaning Products",
    "Mindful Cooking Practices",
    "Educate Yourself",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco-Friendly Cooking Tips'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tips.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  tips[index],
                  style: const TextStyle(fontSize: 18.0),
                ),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {

                },
              ),
            );
          },
        ),
      ),
    );
  }
}
