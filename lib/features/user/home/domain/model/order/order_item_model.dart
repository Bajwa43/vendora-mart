// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderItemModel {
  final String orderItemID;
  final String productID;
  final String quantityOfProduct;
  OrderItemModel({
    required this.orderItemID,
    required this.productID,
    required this.quantityOfProduct,
  });

  OrderItemModel copyWith({
    String? orderItemID,
    String? productID,
    String? quantityOfProduct,
  }) {
    return OrderItemModel(
      orderItemID: orderItemID ?? this.orderItemID,
      productID: productID ?? this.productID,
      quantityOfProduct: quantityOfProduct ?? this.quantityOfProduct,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderItemID': orderItemID,
      'productID': productID,
      'quantityOfProduct': quantityOfProduct,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      orderItemID: map['orderItemID'] as String,
      productID: map['productID'] as String,
      quantityOfProduct: map['quantityOfProduct'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromJson(String source) =>
      OrderItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OrderItemModel(orderItemID: $orderItemID, productID: $productID, quantityOfProduct: $quantityOfProduct)';

  @override
  bool operator ==(covariant OrderItemModel other) {
    if (identical(this, other)) return true;

    return other.orderItemID == orderItemID &&
        other.productID == productID &&
        other.quantityOfProduct == quantityOfProduct;
  }

  @override
  int get hashCode =>
      orderItemID.hashCode ^ productID.hashCode ^ quantityOfProduct.hashCode;
}
