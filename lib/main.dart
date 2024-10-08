import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_store_keeping/screens/login_screen.dart';
import 'package:mobile_store_keeping/screens/signup_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title',
      initialRoute: '/signup', // Initial route
      getPages: [
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()), // Login screen route
      ],
      home: const SignupScreen(), // Optional: You can also set an initial screen
    );
  }
}
