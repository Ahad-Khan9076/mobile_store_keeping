import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true; // Toggle state for notifications
  bool _darkModeEnabled = false; // Toggle state for dark mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Section: Account Settings
          _buildSectionHeader('Account Settings'),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            subtitle: Text('Update your profile information'),
            onTap: () {
              // Navigate to Profile Screen
              Get.toNamed('/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            subtitle: Text('Update your password'),
            onTap: () {
              // Navigate to Change Password Screen
              Get.toNamed('/change-password');
            },
          ),
          Divider(),

          // Section: Preferences
          _buildSectionHeader('Preferences'),
          SwitchListTile(
            title: Text('Enable Notifications'),
            subtitle: Text('Receive app notifications'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Dark Mode'),
            subtitle: Text('Use dark theme throughout the app'),
            value: _darkModeEnabled,
            onChanged: (bool value) {
              setState(() {
                _darkModeEnabled = value;
                // Update theme using GetX or another state management solution
                // Example:
                // Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            subtitle: Text('Select app language'),
            onTap: () {
              _showLanguageDialog();
            },
          ),
          Divider(),

          // Section: Other Settings
          _buildSectionHeader('Other Settings'),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            subtitle: Text('Learn more about the app'),
            onTap: () {
              // Navigate to About Screen
              Get.toNamed('/about');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  // Widget to build section headers
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  // Method to show language selection dialog
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('English'),
                onTap: () {
                  // Set language to English
                  Get.updateLocale(Locale('en', 'US'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Urdu'),
                onTap: () {
                  // Set language to Urdu
                  Get.updateLocale(Locale('ur', 'PK'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Spanish'),
                onTap: () {
                  // Set language to Spanish
                  Get.updateLocale(Locale('es', 'ES'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to show logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Perform logout
                Get.offAllNamed('/login');
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
