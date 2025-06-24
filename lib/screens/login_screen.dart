import 'package:demo_app/graphql/auth_service.dart';
import 'package:demo_app/screens/create_session_screen.dart';
import 'package:demo_app/services/secure_storage_service.dart';
import 'package:demo_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void performLogin(context, String text) async {
    final token = await loginClinician(text);

    if (token != null) {
      SecureStorageService.storeAuthToken(token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CreateSessionScreen()),
      );
    }
  }

  final loginFormController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Lottie.asset(
              'assets/login.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
              repeat: true,
              reverse: true,
              animate: true,
            ),
            Column(
              children: [
                Text("Welcome to", style: AppStyles.welcomeText(context)),
                Text("Tiny Motion", style: AppStyles.welcomeText(context)),
              ],
            ),
            Text(
              "Use your clinicilan ID to create a new session",
              style: AppStyles.normalText(context),
            ),
            AppStyles.glassTextField(
              controller: loginFormController,
              hint: "Clicilian ID",
            ),
            AppStyles.confirmButton(
              onPressed: () async {
                performLogin(context, loginFormController.text);
              },
              text: "Get Started",
            ),
          ],
        ),
      ),
    );
  }
}
