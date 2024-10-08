import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_store_keeping/themes/theme.dart';

import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample user data (replace with actual user data)
    String firstName = 'John';
    String lastName = 'Doe';
    String email = 'john.doe@example.com';
    String password = '********'; // Hide password for security

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Picture
              Center(
                child: CircleAvatar(
                  radius: 60, // Radius of the profile picture
                  // backgroundImage: AssetImage('assets/profile_picture.jpg'), // Replace with actual image
                ),
              ),
              SizedBox(height: 20),

              // User Details in Rectangular Cards
              Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: ListTile(
                  title: Text('First Name'),
                  subtitle: Text(firstName),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: ListTile(
                  title: Text('Last Name'),
                  subtitle: Text(lastName),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: ListTile(
                  title: Text('Email'),
                  subtitle: Text(email),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: ListTile(
                  title: Text('Password'),
                  subtitle: TextField(
                    obscureText: true, // Hide the password
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your password',
                    ),
                  ),
                ),
              ),

              // Edit Button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement your edit functionality or navigation here
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  elevation: 4,
                ),
                child: Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement logout functionality
          Get.offAll(() => LoginScreen()); // Navigate to login screen after logout
        },
        child: Icon(Icons.logout),
        backgroundColor: AppTheme.secondaryColor,
        tooltip: 'Logout',
      ),
    );
  }
}
