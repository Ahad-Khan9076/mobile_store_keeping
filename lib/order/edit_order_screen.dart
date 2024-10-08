import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: EditOrderScreen(),
  ));
}

class EditOrderController extends GetxController {
  var selectedPaymentMethod = ''.obs; // Reactive variable for payment method
  var selectedCategory = ''.obs;

  void setPaymentMethod(String value) {}

  void setCategory(String value) {} // Reactive variable for category
}

class EditOrderScreen extends StatelessWidget {
  final EditOrderController controller = Get.put(EditOrderController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Key for the form

  // List to hold product rows
  // final List<Widget> productRows = [ProductRow(onDelete: () {  })];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Orders'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form( // Using Form widget
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Orders',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // Customer and Contact Fields
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(label: 'Customer Name', value: 'laiba'),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(label: 'Contact', value: '0368998888'),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Address Field
                _buildTextField(label: 'Address', value: 'phase 2 line 5 house 13'),
                SizedBox(height: 20),

                // Payment Method Options
                Text(
                  'Paid Via',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                _buildRadioOptions(),
                SizedBox(height: 20),

                // Dynamic Order Details
                _buildOrderDetailsCard(context),
                SizedBox(height: 20),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // // Add new product row
                        // productRows.add(ProductRow(onDelete: () {
                        //   productRows.removeLast(); // Remove last row
                        //   (context as Element).markNeedsBuild(); // Rebuild to show new row
                        // }));
                        (context as Element).markNeedsBuild(); // Rebuild to show new row
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                      child: Text('Add Items'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle form submission
                          Get.snackbar('Success', 'Order placed successfully!');
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                      child: Text('Place Order'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to build a basic text field
  Widget _buildTextField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: value,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  // Method to build order details card
  Widget _buildOrderDetailsCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTableHeader(),
            SizedBox(height: 8),
            Column(
              // children: productRows,
            ),
          ],
        ),
      ),
    );
  }

  // Method to build table headers
  Widget _buildTableHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Category',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            'Product Name',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            'Price',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            'Number of items',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // Method to build product row widget
  Widget ProductRow({required VoidCallback onDelete}) {
    final EditOrderController controller = Get.find(); // Access the controller

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: DropdownButtonFormField<String>(
              hint: Text('Select a category'),
              items: [
                DropdownMenuItem(value: 'Category 1', child: Text('Category 1')),
                DropdownMenuItem(value: 'Category 2', child: Text('Category 2')),
                DropdownMenuItem(value: 'Category 3', child: Text('Category 3')),
              ],
              onChanged: (value) {
                if (value != null) {
                  controller.setCategory(value);
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Please select a category';
                }
                return null;
              },
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Product name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product name';
                }
                return null;
              },
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Price',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter price';
                }
                return null;
              },
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Number of items',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter number of items';
                }
                return null;
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  // Method to build radio button options
  Widget _buildRadioOptions() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildRadioOption('Credit Card'),
          SizedBox(width: 16),
          _buildRadioOption('Jazz Cash'),
          SizedBox(width: 16),
          _buildRadioOption('Easypaisa'),
        ],
      );
    });
  }

  // Method to build a single radio button
  Widget _buildRadioOption(String title) {
    return Row(
      children: [
        Radio(
          value: title,
          groupValue: controller.selectedPaymentMethod.value,
          onChanged: (value) {
            if (value != null) {
              controller.setPaymentMethod(value);
            }
          },
        ),
        Text(title),
      ],
    );
  }
}
