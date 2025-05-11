import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendoora_mart/features/admin/controller/admin_controller.dart';

class AdminVendorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminNavController>();
    print('VENDOR > ${controller.listOfVendors[1]}');

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "🏪 Vendors Overview",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search vendors by name or ID...',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Vendor List Placeholder
              Expanded(
                child: ListView.builder(
                  itemCount: controller.listOfVendors
                      .length, // Replace with your vendor list length
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Image.network(
                            controller.listOfVendors[index].logoUrl ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error, color: Colors.red);
                            },
                          ),
                        ),
                        title: Text("Vendor ${index + 1}"),
                        subtitle: Text(
                            "Email: ${controller.listOfVendors[index].email}\nTotal Products: ${10 + index * 2}"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // Navigate to vendor profile/details
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
