import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendoora_mart/features/admin/controller/admin_controller.dart';

class AdminProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminNavController>();
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
                "📦 Products Catalog",
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
                  hintText: 'Search products by name or ID...',
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

              // Product List Placeholder
              Expanded(
                child: ListView.builder(
                  itemCount: controller.listOfProducts
                      .length, // Replace with your product list length
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300],
                          ),
                          // child:Icon(Icons.image, color: Colors.white),
                          child: Image.network(
                            controller.listOfProducts[index].images.first ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error, color: Colors.red);
                            },
                          ),
                        ),
                        title: Text(controller.listOfProducts[index].productName
                            .toString()),
                        subtitle: Text(
                            "Category: ${controller.listOfProducts[index].fashionCategory}\nPrice: \$${controller.listOfProducts[index].price}"),
                        trailing: Icon(Icons.edit, size: 18),
                        onTap: () {
                          // Navigate to product edit/details
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
