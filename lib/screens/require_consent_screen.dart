import 'package:demo_app/screens/create_consent_screen.dart';

import 'package:demo_app/services/email_to_service.dart';
import 'package:demo_app/theme/theme.dart';
import 'package:demo_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class RequireConsentScreen extends StatefulWidget {
  const RequireConsentScreen({super.key, required this.sessionId});
  final String? sessionId;

  @override
  State<RequireConsentScreen> createState() => _RequireConsentScreenState();
}

class _RequireConsentScreenState extends State<RequireConsentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "Require Consent"),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              "Do you require consent?",
              style: AppStyles.headingText(context),
            ),
            Text(
              "Select an option below to continue",
              style: AppStyles.normalText(context),
            ),
            AppStyles.customListTile(
              leadingIcon: Icons.assignment_outlined,
              title: "Collect consent now",
              subtitle: "I haven't collected consent",
              trailingIcon: Icons.arrow_forward_ios,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateConsentScreen(),
                  ),
                );
              },
            ),
            AppStyles.customListTile(
              leadingIcon: Icons.email_outlined,
              title: "Email copy of consent",
              subtitle: "I have already collected consent",
              trailingIcon: Icons.arrow_forward_ios,
              onTap: () {
                // Wont work on the emulator
                EmailHelper.launchEmail(
                  email: '',
                  subject: 'Consent Details',
                  body: 'This is the session id ${widget.sessionId}',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
