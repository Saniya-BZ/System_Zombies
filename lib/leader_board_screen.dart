import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<LeaderboardEntry> leaderboardData = [
    LeaderboardEntry(
      position: 1,
      userName: "John Doe",
      score: 1500,
      avatarIcon: Icons.person,
    ),
    LeaderboardEntry(
      position: 2,
      userName: "Jane Smith",
      score: 1200,
      avatarIcon: Icons.person,
    ),
    LeaderboardEntry(
      position: 3,
      userName: "Alice Johnson",
      score: 1100,
      avatarIcon: Icons.person,
    ),
    LeaderboardEntry(
      position: 4,
      userName: "Bob Williams",
      score: 1000,
      avatarIcon: Icons.person,
    ),
    // Add more leaderboard entries as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leaderboard"),
      ),
      body: ListView.builder(
        itemCount: leaderboardData.length,
        itemBuilder: (context, index) {
          return LeaderboardEntryCard(leaderboardData[index]);
        },
      ),
    );
  }
}

class LeaderboardEntry {
  final int position;
  final String userName;
  final int score;
  final IconData avatarIcon;

  LeaderboardEntry({
    required this.position,
    required this.userName,
    required this.score,
    required this.avatarIcon,
  });
}

class LeaderboardEntryCard extends StatelessWidget {
  final LeaderboardEntry entry;

  LeaderboardEntryCard(this.entry);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(entry.avatarIcon),
        ),
        title: Text("${entry.position}. ${entry.userName}"),
        subtitle: Text("Score: ${entry.score}"),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LeaderboardScreen(),
  ));
}