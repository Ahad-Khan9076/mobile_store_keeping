// admin_dashboard_controller.dart
import 'package:get/get.dart';

class AdminDashboardController extends GetxController {
  var totalEarnings = 10000.obs; // Observable for total earnings
  var vendorRegistrations = 25.obs; // Observable for vendor registrations

  // Method to update earnings (this can be expanded)
  void updateEarnings(int amount) {
    totalEarnings.value += amount;
  }

  // Method to update vendor registrations
  void updateVendorRegistrations(int count) {
    vendorRegistrations.value += count;
  }
}
