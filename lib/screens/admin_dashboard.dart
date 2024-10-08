import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_store_keeping/themes/theme.dart';

import '../charts/production_sale_chart.dart';
import '../charts/sales_chart.dart';
import '../charts/vendor_activity_chart.dart'; // Import the Vendor Activity Chart
import '../controllers/admin_dashboard_controller.dart';
import '../widgets/upcoming_qbr.dart'; // Import the Upcoming QBR widget
// import 'admin_dashboard_controller.dart'; // Import the controller
class AdminDashboard extends StatelessWidget {
  final AdminDashboardController controller = Get.put(AdminDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Removed the title text
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://example.com/profile_pic.png'), // Replace with actual URL
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    // Implement settings action
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(), // Build the drawer
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EarningsCard(),
                SizedBox(width: 16),
                VendorRegistrationsCard(),
              ],
            ),
            SalesChart(),
            ProductionSalesChart(),
            VendorActivityChart(), // Add Vendor Activity Chart
            UpcomingQBR(), // Add Upcoming QBR section
          ],
        ),
      ),
    );
  }

  // Method to build the drawer
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('John Doe'), // Replace with actual username
            accountEmail: Text('john.doe@example.com'), // Replace with actual email
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://example.com/profile_pic.png'), // Replace with actual URL
            ),
          ),
          _buildCard('Products', [
            _buildDrawerItem(Icons.list, 'All Products'),
            _buildDrawerItem(Icons.category, 'Categories'),
            _buildDrawerItem(Icons.add, 'Add Product'),
          ]),
          _buildCard('Orders', [
            _buildDrawerItem(Icons.list_alt, 'Order List'),
            _buildDrawerItem(Icons.pending, 'Pending Orders'),
            _buildDrawerItem(Icons.check_circle, 'Completed Orders'),
          ]),
          _buildCard('Inventory', [
            _buildDrawerItem(Icons.visibility, 'View Inventory'),
            _buildDrawerItem(Icons.warning, 'Low Stock Items'),
          ]),
          _buildCard('Reports', [
            _buildDrawerItem(Icons.bar_chart, 'Sales Reports'),
            _buildDrawerItem(Icons.pie_chart, 'Inventory Reports'),
          ]),
        ],
      ),
    );
  }

  // Method to build a card with sub-items
  Widget _buildCard(String title, List<Widget> items) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        children: items,
      ),
    );
  }

  // Method to create a drawer item with an icon
  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // Navigator.pop(context); // Close the drawer when an item is tapped
        // Implement navigation to the respective screen here
      },
    );
  }
}

// EarningsCard and VendorRegistrationsCard classes remain unchanged

// earnings_card.dart
class EarningsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminDashboardController>(); // Get the controller
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column( // Use Obx to listen for changes
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Earnings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.secondaryColor),
            ),
            SizedBox(height: 10),
            Text(
              '\$${controller.totalEarnings}', // Display the total earnings
              style: TextStyle(fontSize: 36, color: Colors.black),
            ),
          ],
        )),
      ),
    );
  }
}

// vendor_registrations_card.dart
class VendorRegistrationsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminDashboardController>(); // Get the controller
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column( // Use Obx to listen for changes
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vendor Registrations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.secondaryColor),
            ),
            SizedBox(height: 10),
            Text(
              '${controller.vendorRegistrations} new vendors registered this month', // Display the vendor registrations
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        )),
      ),
    );
  }
}
