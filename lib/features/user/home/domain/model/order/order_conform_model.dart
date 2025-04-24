import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'order_item_model.dart'; // Adjust this import path if needed

class OrderConformModel {
  final String orderID;
  final String userID;
  final List<OrderItemModel> orderItem;
  final Timestamp orderDate;
  final String paymentMethod;
  final double totalAmount;

  OrderConformModel({
    required this.orderID,
    required this.userID,
    required this.orderItem,
    required this.orderDate,
    required this.paymentMethod,
    required this.totalAmount,
  });

  OrderConformModel copyWith({
    String? orderID,
    String? userID,
    List<OrderItemModel>? orderItem,
    Timestamp? orderDate,
    String? paymentMethod,
    double? totalAmount,
  }) {
    return OrderConformModel(
      orderID: orderID ?? this.orderID,
      userID: userID ?? this.userID,
      orderItem: orderItem ?? this.orderItem,
      orderDate: orderDate ?? this.orderDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderID': orderID,
      'userID': userID,
      'orderItem': orderItem.map((x) => x.toMap()).toList(),
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'totalAmount': totalAmount,
    };
  }

  factory OrderConformModel.fromMap(Map<String, dynamic> map) {
    return OrderConformModel(
      orderID: map['orderID'] ?? '',
      userID: map['userID'] ?? '',
      orderItem: List<OrderItemModel>.from(
        (map['orderItem'] as List).map((x) => OrderItemModel.fromMap(x)),
      ),
      orderDate: map['orderDate'] as Timestamp,
      paymentMethod: map['paymentMethod'] ?? '',
      totalAmount: (map['totalAmount'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderConformModel.fromJson(String source) =>
      OrderConformModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderConformModel(orderID: $orderID, userID: $userID, orderItem: $orderItem, orderDate: $orderDate, paymentMethod: $paymentMethod, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderConformModel &&
        other.orderID == orderID &&
        other.userID == userID &&
        listEquals(other.orderItem, orderItem) &&
        other.orderDate == orderDate &&
        other.paymentMethod == paymentMethod &&
        other.totalAmount == totalAmount;
  }

  @override
  int get hashCode {
    return orderID.hashCode ^
        userID.hashCode ^
        orderItem.hashCode ^
        orderDate.hashCode ^
        paymentMethod.hashCode ^
        totalAmount.hashCode;
  }
}
