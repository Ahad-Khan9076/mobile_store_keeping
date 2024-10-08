import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrderScreen extends StatefulWidget {
  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _selectedPaymentMethod = 'JazzCash';

  final List<Map<String, dynamic>> _items = [
    {'category': 'Electronics', 'productName': 'Smartphone', 'price': 300, 'number': 2},
    {'category': 'Clothing', 'productName': 'T-shirt', 'price': 20, 'number': 5},
    // Additional items for demonstration
    {'category': 'Home Appliances', 'productName': 'Washing Machine', 'price': 500, 'number': 1},
    {'category': 'Books', 'productName': 'Flutter Development', 'price': 40, 'number': 3},
    {'category': 'Furniture', 'productName': 'Sofa', 'price': 700, 'number': 1},
    {'category': 'Toys', 'productName': 'Lego Set', 'price': 60, 'number': 4},
  ]; // Sample data for purchased items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Order'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[200]!, Colors.teal[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildCustomerInfoFields(),
                const SizedBox(height: 16.0),
                _buildPaymentMethodDropdown(),
                const SizedBox(height: 16.0),
                _buildPurchasedItemsTable(),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitOrder,
                  child: Text('Submit Order'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerInfoFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(_customerNameController, 'Customer Name'),
        const SizedBox(height: 8.0),
        _buildTextField(_contactNumberController, 'Contact Number'),
        const SizedBox(height: 8.0),
        _buildTextField(_addressController, 'Address'),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 4, // Adds shadow for depth
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodDropdown() {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 4, // Adds shadow for depth
        child: DropdownButton<String>(
          value: _selectedPaymentMethod,
          items: <String>['JazzCash', 'EasyPaisa', 'Card'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedPaymentMethod = newValue!;
            });
          },
          isExpanded: true,
          hint: Text("Select Payment Method"),
          style: TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }

  Widget _buildPurchasedItemsTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Card(
        elevation: 4, // Adds shadow for depth
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Product Name', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Price', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Number', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: _items.map((item) {
              return DataRow(cells: [
                DataCell(Text(item['category'])),
                DataCell(Text(item['productName'])),
                DataCell(Text(item['price'].toString())),
                DataCell(Text(item['number'].toString())),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _submitOrder() {
    String customerName = _customerNameController.text;
    String contactNumber = _contactNumberController.text;
    String address = _addressController.text;

    if (customerName.isEmpty || contactNumber.isEmpty || address.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields.");
      return;
    }

    Get.snackbar("Success", "Order submitted successfully.");
    // Implement further order submission logic here
  }
}
