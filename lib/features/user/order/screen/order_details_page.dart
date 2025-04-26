import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
      'Order Details Page',
      style: TextStyle(fontSize: 24),
    )));
  }
}
