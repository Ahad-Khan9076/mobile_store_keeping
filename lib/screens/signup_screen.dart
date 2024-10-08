import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart'; // Import the package
import '../themes/theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(); // Controller for phone number

  String? selectedCountryCode = "+92"; // Default country code for Pakistan

  bool _isPasswordValid(String password) {
    final RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[!@#$%^&*])[A-Za-z\d!@#$%^&*]{6,}$');
    return regex.hasMatch(password);
  }

  Future<void> _signup() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!_isPasswordValid(passwordController.text)) {
      Get.snackbar('Error', 'Password must contain at least one uppercase letter, one special character, and be at least 6 characters long.', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      // Create user in Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Get the Firestore instance
      final userRef = FirebaseFirestore.instance.collection('users');

      // Save user data to Firestore
      await userRef.doc(userCredential.user!.uid).set({
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'country': countryController.text.trim(),
        'phone': '$selectedCountryCode ${phoneController.text.trim()}', // Save the phone number with country code
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar('Sign Up', 'Account Created Successfully!', snackPosition: SnackPosition.BOTTOM);
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
                    "Get started with us",
                    style: AppTheme.header1.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Complete these easy steps to register your account",
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
                            "Sign up your account",
                            style: AppTheme.header1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            "Enter your personal data to create your account",
                            style: AppTheme.header3,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Expanded(
                              child: SocialButton(
                                label: "Google",
                                icon: FontAwesomeIcons.google,
                                iconColor: AppTheme.secondaryColor,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: SocialButton(
                                label: "Github",
                                labelColor: AppTheme.darkColor,
                                icon: FontAwesomeIcons.github,
                                iconColor: AppTheme.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Expanded(
                                child: Divider(thickness: 2, color: Colors.black45)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text("or"),
                            ),
                            Expanded(
                                child: Divider(thickness: 2, color: Colors.black45)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                label: "First Name",
                                hintText: "eg. John",
                                controller: firstNameController,

                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomTextField(
                                label: "Last Name",
                                hintText: "eg. Francisco",
                                controller: lastNameController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          label: "Country",
                          hintText: "Enter your country",
                          controller: countryController,
                        ),
                        const SizedBox(height: 20),
                        // Phone Number Field with Country Code Picker
                        Row(
                          children: [
                            CountryCodePicker(
                              onChanged: (code) {
                                setState(() {
                                  selectedCountryCode = code.dialCode; // Update selected country code
                                });
                              },
                              initialSelection: 'PK', // Set default country code to Pakistan
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              favorite: const ['+92', 'PK'], // Show Pakistan as favorite
                              textStyle: const TextStyle(color: Colors.black),
                            ),
                            Expanded(
                              child: CustomTextField(
                                label: "Phone Number",
                                hintText: "Enter your phone number",
                                controller: phoneController,

                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          label: "Email",
                          hintText: "Enter your email",
                          controller: emailController,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          label: "Password",
                          hintText: "Enter your password",
                          obscureText: true,
                          showHintBelow: true,
                          controller: passwordController,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          label: "Confirm Password",
                          hintText: "Re-enter your password",
                          obscureText: true,
                          showHintBelow: true,
                          controller: confirmPasswordController,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _signup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondaryColor,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/login');
                              },
                              child: const Text("Login",
                                  style: TextStyle(color: Colors.teal)),
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
