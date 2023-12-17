// import 'package:flutter/material.dart';
//
// class QuizQuestion {
//   final String question;
//   final String correctOption;
//   final List<String> options;
//
//   QuizQuestion({
//     required this.question,
//     required this.correctOption,
//     required this.options,
//   });
// }
//
// class QuizScreen extends StatefulWidget {
//   const QuizScreen({Key? key}) : super(key: key);
//
//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }
//
// class _QuizScreenState extends State<QuizScreen> {
//   final List<QuizQuestion> questions = [
//     QuizQuestion(
//       question: "Which ingredient is commonly used in the recipe for 'Pasta Carbonara'?",
//       correctOption: "Bacon",
//       options: ["Chicken", "Tofu", "Bacon", "Salmon"],
//     ),
//     QuizQuestion(
//       question: "What is the main source of protein in a vegetarian lasagna?",
//       correctOption: "Tofu",
//       options: ["Chicken", "Beef", "Tofu", "Salmon"],
//     ),
//     QuizQuestion(
//       question: "Which cooking method is commonly used in grilling?",
//       correctOption: "Direct heat",
//       options: ["Boiling", "Baking", "Steaming", "Direct heat"],
//     ),
//     QuizQuestion(
//       question: "What is the primary greenhouse gas produced by livestock?",
//       correctOption: "Methane",
//       options: ["Carbon dioxide", "Nitrous oxide", "Methane", "Ozone"],
//     ),
//     QuizQuestion(
//       question: "Which type of diet is known for reducing carbon emissions?",
//       correctOption: "Plant-based",
//       options: ["Ketogenic", "Paleo", "Mediterranean", "Plant-based"],
//     ),
//     QuizQuestion(
//       question: "In a classic Caesar salad, what is a key ingredient in the dressing?",
//       correctOption: "Anchovies",
//       options: ["Mustard", "Mayonnaise", "Anchovies", "Vinegar"],
//     ),
//     QuizQuestion(
//       question: "What is the primary ingredient in traditional Japanese miso soup?",
//       correctOption: "Miso paste",
//       options: ["Tofu", "Seaweed", "Ramen noodles", "Miso paste"],
//     ),
//     QuizQuestion(
//       question: "Which cooking method is commonly used in stir-frying?",
//       correctOption: "High heat and quick cooking",
//       options: ["Low heat and slow cooking", "Baking", "Boiling", "High heat and quick cooking"],
//     ),
//   ];
//
//   int currentQuestionIndex = 0;
//   String? selectedOption;
//   int correctAnswers = 0;
//
//   bool get isCurrentQuestionAnswered => selectedOption != null;
//
//   bool showSummary = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Daily Quiz Challenge"),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             if (!showSummary)
//               QuizCard(
//                 question: questions[currentQuestionIndex],
//                 selectedOption: selectedOption,
//                 onOptionSelected: (value) {
//                   setState(() {
//                     selectedOption = value;
//                   });
//                 },
//               ),
//             if (!showSummary) SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: isCurrentQuestionAnswered
//                   ? () {
//                 // Check the answer
//                 if (selectedOption == questions[currentQuestionIndex].correctOption) {
//                   correctAnswers++;
//                 }
//
//                 // Move to the next question or show the final result
//                 setState(() {
//                   if (currentQuestionIndex < questions.length - 1) {
//                     currentQuestionIndex++;
//                     selectedOption = null; // Reset selected option for the next question
//                   } else {
//                     // Quiz completed, show the summary on the screen
//                     showSummary = true;
//                   }
//                 });
//               }
//                   : null,
//               child: Text(showSummary ? "OK" : "Next"),
//             ),
//             if (showSummary)
//               Column(
//                 children: [
//                   SizedBox(height: 16.0),
//                   Text("Quiz Completed"),
//                   Text("You got $correctAnswers correct out of ${questions.length} questions."),
//                   SizedBox(height: 8.0),
//                   Text("You've completed the challenge for today. Come back tomorrow for another quiz!"),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class QuizCard extends StatelessWidget {
//   final QuizQuestion question;
//   final String? selectedOption;
//   final ValueChanged<String?> onOptionSelected;
//
//   QuizCard({
//     required this.question,
//     required this.selectedOption,
//     required this.onOptionSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4.0,
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               question.question,
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16.0),
//             for (var option in question.options)
//               RadioListTile<String>(
//                 title: Text(option),
//                 value: option,
//                 groupValue: selectedOption,
//                 onChanged: (value) {
//                   onOptionSelected(value);
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'tips_screen.dart';

class QuizQuestion {
  final String question;
  final String correctOption;
  final List<String> options;

  QuizQuestion({
    required this.question,
    required this.correctOption,
    required this.options,
  });
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<QuizQuestion> questions = [

  QuizQuestion(
      question: "Which ingredient is commonly used in the recipe for 'Pasta Carbonara'?",
      correctOption: "Bacon",
      options: ["Chicken", "Tofu", "Bacon", "Salmon"],
    ),
    QuizQuestion(
      question: "What is the main source of protein in a vegetarian lasagna?",
      correctOption: "Tofu",
      options: ["Chicken", "Beef", "Tofu", "Salmon"],
    ),
    QuizQuestion(
      question: "Which cooking method is commonly used in grilling?",
      correctOption: "Direct heat",
      options: ["Boiling", "Baking", "Steaming", "Direct heat"],
    ),
    QuizQuestion(
      question: "What is the primary greenhouse gas produced by livestock?",
      correctOption: "Methane",
      options: ["Carbon dioxide", "Nitrous oxide", "Methane", "Ozone"],
    ),
    QuizQuestion(
      question: "Which type of diet is known for reducing carbon emissions?",
      correctOption: "Plant-based",
      options: ["Ketogenic", "Paleo", "Mediterranean", "Plant-based"],
    ),
    QuizQuestion(
      question: "In a classic Caesar salad, what is a key ingredient in the dressing?",
      correctOption: "Anchovies",
      options: ["Mustard", "Mayonnaise", "Anchovies", "Vinegar"],
    ),
    QuizQuestion(
      question: "What is the primary ingredient in traditional Japanese miso soup?",
      correctOption: "Miso paste",
      options: ["Tofu", "Seaweed", "Ramen noodles", "Miso paste"],
    ),
    QuizQuestion(
      question: "Which cooking method is commonly used in stir-frying?",
      correctOption: "High heat and quick cooking",
      options: ["Low heat and slow cooking", "Baking", "Boiling", "High heat and quick cooking"],
    ),
  ];

  int currentQuestionIndex = 0;
  String? selectedOption;
  int correctAnswers = 0;

  bool get isCurrentQuestionAnswered => selectedOption != null;

  bool showSummary = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Quiz Challenge"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!showSummary)
              QuizCard(
                question: questions[currentQuestionIndex],
                selectedOption: selectedOption,
                onOptionSelected: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
            if (!showSummary) SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isCurrentQuestionAnswered
                  ? () {

                if (selectedOption == questions[currentQuestionIndex].correctOption) {
                  correctAnswers++;
                }


                setState(() {
                  if (currentQuestionIndex < questions.length - 1) {
                    currentQuestionIndex++;
                    selectedOption = null;
                  } else {

                    showSummaryDialog(context);
                  }
                });
              }
                  : null,
              child: Text(showSummary ? "OK" : "Next"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showSummaryDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Quiz Completed"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("You got $correctAnswers correct out of ${questions.length} questions."),
              SizedBox(height: 8.0),
              Text("You've completed the challenge for today. Come back tomorrow for another quiz!"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  TipsScreen()),
                );

              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


  // ... (unchanged)
  class QuizCard extends StatelessWidget {
  final QuizQuestion question;
  final String? selectedOption;
  final ValueChanged<String?> onOptionSelected;

  QuizCard({
  required this.question,
  required this.selectedOption,
  required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            for (var option in question.options)
              RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: selectedOption,
                onChanged: (value) {
                  onOptionSelected(value);
                },
              ),
          ],
        ),
      ),
    );
  }
}