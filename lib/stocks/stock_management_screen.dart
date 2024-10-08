import 'package:flutter/material.dart';
import 'package:mobile_store_keeping/stocks/stock_details.dart';

void main() {
  runApp(MaterialApp(
    home: StockManagementScreen(),
  ));
}

class StockManagementScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {'category': 'Category 1', 'name': 'Product 1', 'brand': 'Gucci', 'quantity': 30},
    {'category': 'Category 2', 'name': 'Product 2', 'brand': 'Gucci', 'quantity': 10},
    {'category': 'Category 3', 'name': 'Product 3', 'brand': 'Gucci', 'quantity': 20},
    {'category': 'Category 4', 'name': 'Product 4', 'brand': 'Gucci', 'quantity': 50},
    {'category': 'Category 5', 'name': 'Product 5', 'brand': 'Gucci', 'quantity': 10},
    {'category': 'Category 6', 'name': 'Product 6', 'brand': 'Gucci', 'quantity': 20},
    {'category': 'Category 7', 'name': 'Product 7', 'brand': 'Gucci', 'quantity': 90},
    {'category': 'Category 8', 'name': 'Product 8', 'brand': 'Gucci', 'quantity': 70},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _buildSearchBar(),
            _buildFiltersButton(),
            // Use StockDetail class to display each product
            ...products.map((product) => StockDetail(product)).toList(),
          ],
        ),
      ),
    );
  }

  // Search bar widget
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // Filters button
  Widget _buildFiltersButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton.icon(
        icon: Icon(Icons.filter_list),
        label: Text('Filters'),
        onPressed: () {
          // Add filter action here
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}