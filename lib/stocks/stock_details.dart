import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockDetail extends StatelessWidget {
  final Map<String, dynamic> product;

  StockDetail(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Category icon
            CircleAvatar(
              child: Text(product['category'][0]), // Show the first letter of the category
            ),
            SizedBox(width: 12),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Brand: ${product['brand']}'),
                  Text('Category: ${product['category']}'),
                ],
              ),
            ),
            // Quantity and Add button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Quantity: ${product['quantity']}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle, color: Colors.green),
                  onPressed: () {
                    // Add action for increasing quantity
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}