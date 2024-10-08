import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:mobile_store_keeping/order/edit_order_screen.dart';
import 'package:mobile_store_keeping/order/order_list.dart';
import 'package:mobile_store_keeping/screens/admin_dashboard.dart';
import '../themes/theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true; // State to manage password visibility
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Logic to authenticate user
    try {
      // Here you should implement your authentication logic, e.g., checking Firestore
      // Assuming you have a collection "users" in Firestore with fields: email, password, and role

      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password) // Replace with hashed password checking in production
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        String role = userSnapshot.docs.first['role']; // Get user role

        // Redirect based on user role
        if (role == 'admin') {
          Get.toNamed('/adminDashboard'); // Redirect to Admin Dashboard
          // } else if (role == 'seller') {
          //   Get.toNamed('/sellerDashboard'); // Redirect to Seller Dashboard
          // } else if (role == 'buyer') {
          //   Get.to(OrderListScreen()); // Redirect to Buyer Dashboard or Order List
          // }

        } else {
          Get.snackbar('Error', 'Unknown role!', snackPosition: SnackPosition.BOTTOM);
        }

        Get.snackbar('Login', 'Logged in Successfully!', snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Login Failed', 'Incorrect email or password.', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "Welcome Back",
                    style: AppTheme.header1.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Please log in to your account",
                    style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "Login to your account",
                            style: AppTheme.header1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            "Enter your email and password to continue",
                            style: AppTheme.header3,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Email Field
                        CustomTextField(
                          label: "Email",
                          hintText: "Enter your email",
                          controller: _emailController, // Pass the controller
                        ),
                        const SizedBox(height: 20),
                        // Password Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const Text("Password", style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 8),
                            CustomTextField(
                              label: "Password",
                              hintText: "Enter your password",
                              obscureText: _obscurePassword,
                              controller: _passwordController, // Pass the controller
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: !_obscurePassword, // Inverse for Checkbox
                                  onChanged: (value) {
                                    setState(() {
                                      _obscurePassword = !value!; // Update state
                                    });
                                  },
                                ),
                                const Text("Show Password"),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        // Login Button
                        ElevatedButton(
                          onPressed: _login, // Use the login method
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondaryColor,
                            minimumSize: const Size(double.infinity, 50), // Full width button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), // Rectangular shape
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // "Or" Text
                        const Center(child: Text("or")),
                        const SizedBox(height: 20),
                        // Google Social Button
                        const SocialButton(
                          label: "Login with Google",
                          icon: FontAwesomeIcons.google,
                          iconColor: AppTheme.secondaryColor,
                        ),
                        const SizedBox(height: 20),
                        // Navigate to Signup Option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Get.to(AdminDashboard()); // Navigate to Signup Screen
                              },
                              child: const Text("Sign Up", style: TextStyle(color: Colors.teal)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
