import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}
//sample notifs
class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, dynamic>> notifications = [
    {
      'icon': Icons.how_to_vote,
      'text': 'Voting for class officers starts tomorrow at 9:00 AM.',
      'tag': 'Voting',
    },
    {
      'icon': Icons.settings,
      'text': 'System maintenance scheduled for June 5 from 12:00 AM - 2:00 AM.',
      'tag': 'System Update',
    },
    {
      'icon': Icons.warning_amber,
      'text': 'Update your profile information before the next election.',
      'tag': 'Reminder',
    },
    {
      'icon': Icons.bar_chart,
      'text': 'Final results will be published on June 10.',
      'tag': 'Results',
    },
    {
      'icon': Icons.timer,
      'text': 'Voting ends in 2 hours. Cast your vote now!',
      'tag': 'Urgent',
    },
    {
      'icon': Icons.calendar_today,
      'text': 'Deadline for candidacy application is June 3, 5:00 PM.',
      'tag': 'Deadline',
    },
    {
      'icon': Icons.check_circle,
      'text': 'You have successfully submitted your vote.',
      'tag': 'Confirmation',
    },
    {
      'icon': Icons.new_releases,
      'text': 'New features added: Live vote count tracking!',
      'tag': 'Feature',
    },
    {
      'icon': Icons.security,
      'text': 'Unauthorized login attempt detected. Please change your password.',
      'tag': 'Security',
    },
    {
      'icon': Icons.tips_and_updates,
      'text': 'Enable email notifications to stay updated.',
      'tag': 'Tip',
    },
    {
      'icon': Icons.verified_user,
      'text': 'Your student ID has been verified for the election.',
      'tag': 'Verification',
    },
    {
      'icon': Icons.code,
      'text': 'Election system updated to version 2.1.1.',
      'tag': 'System Update',
    },
    {
      'icon': Icons.refresh,
      'text': 'Refresh your browser to see the latest election data.',
      'tag': 'Instruction',
    },
    {
      'icon': Icons.security,
      'text': 'Your account security has been upgraded.',
      'tag': 'Security',
    },
  ];

  void dismissNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                'You have no new notifications.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(item['icon'], color: Colors.blue.shade800),
                    ),
                    title: Text(
                      item['text'],
                      style: const TextStyle(fontSize: 14),
                    ),
                    subtitle: Text(
                      item['tag'],
                      style: TextStyle(color: Colors.blue.shade400),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      tooltip: 'Dismiss',
                      onPressed: () => dismissNotification(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
