import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendoora_mart/features/admin/controller/admin_controller.dart';
// import 'package:vendoora_mart/features/admin/admin_dashboard/controller/admin_nav_controller.dart';

class AdminDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminNavController>();

    return Obx(() {
      final user = controller.adminUser.value;

      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: user == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: user.imageUrl != null &&
                                    user.imageUrl!.isNotEmpty
                                ? (user.imageUrl!.startsWith('http')
                                    ? NetworkImage(user.imageUrl!)
                                    : FileImage(File(user.imageUrl!))
                                        as ImageProvider)
                                : AssetImage(
                                    'assets/images/default_avatar.png'),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.fullName ?? "Admin",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                user.email ?? '',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 30),

                      // Summary Title
                      Text(
                        "📊 Dashboard Summary",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),

                      // Summary Cards
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDashboardCard(
                              title: "Orders",
                              value: "120",
                              color: Colors.blue),
                          _buildDashboardCard(
                              title: "Vendors",
                              value: "15",
                              color: Colors.green),
                          _buildDashboardCard(
                              title: "Products",
                              value: "430",
                              color: Colors.orange),
                        ],
                      ),

                      SizedBox(height: 30),

                      // Welcome Text
                      Text(
                        "Manage everything from your admin panel — from vendors to product inventory and order processing.",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }

  Widget _buildDashboardCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: color.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color),
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
