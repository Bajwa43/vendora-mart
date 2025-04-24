import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vendoora_mart/features/user/home/domain/model/order/order_conform_model.dart';

class ReceiptScreen extends StatelessWidget {
  final OrderConformModel order;

  const ReceiptScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat.yMMMMd().add_jm().format(order.orderDate.toDate());

    return Scaffold(
      backgroundColor: const Color(0xFFF0FAF2),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Success Icon
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.greenAccent.withOpacity(0.2),
                ),
                padding: const EdgeInsets.all(30),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 110,
                ),
              ),
              const SizedBox(height: 25),

              // Heading
              Text(
                "Order Confirmed!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Thank you for your purchase. Your order is being processed.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),

              // Receipt Container
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Column(
                  children: [
                    _buildRow("Order ID:", order.orderID),
                    const Divider(height: 25),
                    _buildRow("Amount Paid:",
                        "Rs. ${order.totalAmount.toStringAsFixed(2)}"),
                    const Divider(height: 25),
                    _buildRow("Payment Method:", order.paymentMethod),
                    const Divider(height: 25),
                    _buildRow("Date:", formattedDate),
                  ],
                ),
              ),
              const SizedBox(height: 35),

              // Continue Button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // or navigate to home screen
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                icon: const Icon(Icons.arrow_forward_ios, size: 18),
                label: const Text(
                  "Continue Shopping",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Flexible(
          child: Text(value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
      ],
    );
  }
}
