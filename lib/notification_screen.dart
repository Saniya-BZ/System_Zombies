import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> notifications = [
    NotificationItem(
      title: "New Recipe Challenge",
      description: "Alex challenged you to create a 'Vegan Buddha Bowl'. Are you up for it?",
      date: "8 hours ago",
    ),
    NotificationItem(
      title: "Weekly Achievement",
      description: "You completed all your weekly eco-friendly meal goals! Keep it up!",
      date: "yesterday",
    ),
    NotificationItem(
      title: "Feature Unlocked",
      description: "You've unlocked the 'Eco-Friendly Tips' section. Explore new sustainable practices!",
      date: "2 days ago",
    ),
    NotificationItem(
      title: "Monthly Challenge",
      description: "Participate in the monthly challenge: Try a new 'Low FODMAP' recipe.",
      date: "4 days ago",
    ),
    NotificationItem(
      title: "Recipe of the Day",
      description: "Check out the recipe of the day: 'Mediterranean Quinoa Salad'.",
      date: "1 months ago",
    ),
    NotificationItem(
      title: "Community Recognition",
      description: "You've been recognized by the community for your eco-friendly cooking habits!",
      date: "2 months ago",
    ),
    NotificationItem(
      title: "Special Event",
      description: "Join our special event: Live cooking session with a renowned chef.",
      date: "7 months ago",
    ),
    NotificationItem(
      title: "Achievement Unlocked",
      description: "Congratulations! You've achieved the 'Green Chef' status.",
      date: "8 months ago",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(notification: notifications[index]);
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(notification.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.description),
            SizedBox(height: 4.0),
            Text(
              notification.date,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Notification tapped: ${notification.title}"),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String description;
  final String date;

  NotificationItem({
    required this.title,
    required this.description,
    required this.date,
  });
}

