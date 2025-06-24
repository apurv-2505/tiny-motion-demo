import 'package:demo_app/screens/create_session_screen.dart';
import 'package:demo_app/screens/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:demo_app/services/secure_storage_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const ProviderScope(
      // Add this
      child: MyApp(), // Your root widget
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> _authCheckFuture;

  @override
  void initState() {
    super.initState();
    _authCheckFuture = checkAuthStatus();
  }

  Future<bool> checkAuthStatus() async {
    final token = await SecureStorageService.getAuthToken();
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GraphQL Login Demo',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _authCheckFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('Error loading app')),
            );
          }

          final isAuthenticated = snapshot.data ?? false;
          return isAuthenticated
              ? const CreateSessionScreen()
              : const LoginScreen();
        },
      ),
    );
  }
}
