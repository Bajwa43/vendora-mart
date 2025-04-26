import 'package:cloud_firestore/cloud_firestore.dart';
import 'order_item_model.dart';

class OrderConformModel {
  final String orderID;
  final String userID;
  final List<OrderItemModel> orderItem;
  final Timestamp orderDate;
  final String paymentMethod;
  final double totalAmount;
  final String paymentSatus;

  OrderConformModel({
    required this.orderID,
    required this.userID,
    required this.orderItem,
    required this.orderDate,
    required this.paymentMethod,
    required this.totalAmount,
    required this.paymentSatus,
  });

  /// Create model from Map
  factory OrderConformModel.fromMap(Map<String, dynamic> map) {
    return OrderConformModel(
      orderID: map['orderID'] ?? '',
      userID: map['userID'] ?? '',
      orderItem: (map['orderItem'] as List)
          .map((item) => OrderItemModel.fromMap(item))
          .toList(),
      orderDate: map['orderDate'],
      paymentMethod: map['paymentMethod'] ?? '',
      totalAmount: (map['totalAmount'] as num).toDouble(),
      paymentSatus: map['paymentSatus'] ?? '',
    );
  }

  /// Convert model to Map
  Map<String, dynamic> toMap() {
    return {
      'orderID': orderID,
      'userID': userID,
      'orderItem': orderItem.map((e) => e.toMap()).toList(),
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'totalAmount': totalAmount,
      'paymentSatus': paymentSatus,
    };
  }
}
