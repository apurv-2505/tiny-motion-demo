import 'package:demo_app/screens/camera_screen.dart';
import 'package:demo_app/theme/theme.dart';
import 'package:demo_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "Checklist"),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Text(
                    "Pre-recording Checklist",
                    style: AppStyles.headingText(context),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(4, 12, 4, 24),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 250, 248, 223),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.taxi_alert,
                            color: Colors.yellow[500],
                          ),
                          title: Text(
                            "Please note",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 4),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            "You will be unable to pause while recording the child's movement",
                            style: AppStyles.normalText(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[50],
                      radius: 24,
                      child: Icon(
                        Icons.wb_sunny_outlined,
                        color: Colors.blue[500],
                        size: 18,
                      ),
                    ),
                    title: Text(
                      "Environment is quiet and warm",
                      style: AppStyles.normalText(context),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[50],
                      radius: 24,
                      child: Icon(
                        Icons.bedroom_baby_outlined,
                        color: Colors.blue[500],
                        size: 18,
                      ),
                    ),
                    title: Text(
                      "Child is only waring a nappy and does not have a dummy",
                      style: AppStyles.normalText(context),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[50],
                      radius: 24,
                      child: Icon(
                        Icons.screen_lock_rotation_outlined,
                        color: Colors.blue[500],
                        size: 18,
                      ),
                    ),
                    title: Text(
                      "Child is laying face up on a plain bedsheet or towel",
                      style: AppStyles.normalText(context),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[50],
                      radius: 24,
                      child: Icon(
                        Icons.punch_clock_outlined,
                        color: Colors.blue[500],
                        size: 18,
                      ),
                    ),
                    title: Text(
                      "Child remains awake, relaxed and within the frame for atleast 1 min",
                      style: AppStyles.normalText(context),
                    ),
                  ),
                ],
              ),
            ),
            AppStyles.confirmButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraScreen()),
                );
              },
              text: "Open camera",
            ),
          ],
        ),
      ),
    );
  }
}
