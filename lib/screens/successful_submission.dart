import 'package:demo_app/graphql/auth_service.dart';
import 'package:demo_app/screens/login_screen.dart';
import 'package:demo_app/theme/theme.dart';

import 'package:flutter/material.dart';

class SuccessfulSubmissionScreen extends StatelessWidget {
  const SuccessfulSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Successful Submission'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logoutClinician();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 80),
            SizedBox(height: 24),
            Text(
              'Submitted Successfully!',
              style: AppStyles.headingText(context),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Your data has been submitted successfully',
              style: AppStyles.normalText(context),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
