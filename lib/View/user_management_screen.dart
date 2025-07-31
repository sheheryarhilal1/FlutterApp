import 'package:flutter/material.dart';
import 'package:get/get.dart';

class User {
  final String email;
  final bool optedIn;
  final String notificationStatus;

  User({
    required this.email,
    required this.optedIn,
    required this.notificationStatus,
  });
}

class UserManagementScreen extends StatelessWidget {
  final List<User> users = [
    User(email: 'user1@example.com', optedIn: true, notificationStatus: 'Delivered'),
    User(email: 'user2@example.com', optedIn: false, notificationStatus: 'Unsubscribed'),
    User(email: 'user3@example.com', optedIn: true, notificationStatus: 'Pending'),
    User(email: 'user4@example.com', optedIn: true, notificationStatus: 'Delivered'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0C097),
      appBar: AppBar(
        title: const Text('User Management', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF6D4C41),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF6D4C41),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.person, color: Colors.white70),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.email,
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            user.optedIn ? 'Opted In' : 'Unsubscribed',
                            style: TextStyle(
                              color: user.optedIn ? Colors.greenAccent : Colors.redAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Status: ${user.notificationStatus}',
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
