import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_store_keeping/order/add_order_screen.dart';
import '../themes/theme.dart';
import 'edit_order_screen.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          children: [
            _buildCustomAppBar(),
            const SizedBox(height: 16.0),
            _buildSearchAndFilterRow(),
            const SizedBox(height: 16.0),
            Expanded( // Move the Expanded here
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(Colors.teal[100]),
                  columns: _buildDataColumns(),
                  rows: List<DataRow>.generate(
                    30, // Number of rows (can be dynamic)
                        (index) => _buildDataRow(index),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement Order Addition Logic
          print("Add Order Button Pressed");
          Get.to(AddOrderScreen()); // Redirect to EditOrderScreen or another screen
        },
        child: Icon(Icons.add),
        backgroundColor: AppTheme.secondaryColor,
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Get.back();
          },
        ),
        CircleAvatar(
          radius: 20, // Adjust the radius as needed
          backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with the actual image URL or asset
        ),
      ],
    );
  }

  Widget _buildSearchAndFilterRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        _buildStatusDropdown(),
      ],
    );
  }

  DropdownButton<String> _buildStatusDropdown() {
    return DropdownButton<String>(
      value: _selectedStatus,
      hint: Text("Status"),
      items: <String>['All', 'Completed', 'Pending']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedStatus = newValue!;
        });
      },
    );
  }

  List<DataColumn> _buildDataColumns() {
    return [
      DataColumn(label: Text('Id')),
      DataColumn(label: Text('Order Id')),
      DataColumn(label: Text('Customer Name')),
      DataColumn(label: Text('Order Date')),
      DataColumn(label: Text('Items')),
      DataColumn(label: Text('Total Price')),
      DataColumn(label: Text('Total Discount')),
      DataColumn(label: Text('Status')),
      DataColumn(label: Text('Actions')),
    ];
  }

  DataRow _buildDataRow(int index) {
    return DataRow(
      color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          return index.isEven ? Colors.grey.withOpacity(0.1) : Colors.white;
        },
      ),
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text('324567')),
        DataCell(Text('laiba asad')),
        DataCell(Text('3-sep-2024')),
        DataCell(Text('1')),
        DataCell(Text('6000')),
        DataCell(Text('10%')),
        _buildStatusCell(index),
        _buildActionCell(index),
      ],
    );
  }

  DataCell _buildStatusCell(int index) {
    return DataCell(
      Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: index.isEven ? Colors.green[100] : Colors.red[100],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          index.isEven ? 'Completed' : 'Pending',
          style: TextStyle(
            color: index.isEven ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  DataCell _buildActionCell(int index) {
    return DataCell(
      Row(
        children: [
          IconButton(
            icon: Icon(Icons.info, color: Colors.grey),
            onPressed: () {
              print("Info Button Pressed");
            },
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              Get.to(EditOrderScreen());
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              print("Delete Button Pressed");
            },
          ),
        ],
      ),
    );
  }
}
