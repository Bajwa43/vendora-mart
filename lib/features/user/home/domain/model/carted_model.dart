// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartedModel {
  final String cartedId;
  final String productId;
  final String image;
  final String productName;
  final String price;
  final String size;
  final String noOfProduct;
  final String categoryType;
  CartedModel({
    required this.cartedId,
    required this.productId,
    required this.image,
    required this.productName,
    required this.price,
    required this.size,
    required this.noOfProduct,
    required this.categoryType,
  });

  CartedModel copyWith({
    String? cartedId,
    String? productId,
    String? image,
    String? productName,
    String? price,
    String? size,
    String? noOfProduct,
    String? categoryType,
  }) {
    return CartedModel(
      cartedId: cartedId ?? this.cartedId,
      productId: productId ?? this.productId,
      image: image ?? this.image,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      size: size ?? this.size,
      noOfProduct: noOfProduct ?? this.noOfProduct,
      categoryType: categoryType ?? this.categoryType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartedId': cartedId,
      'productId': productId,
      'image': image,
      'productName': productName,
      'price': price,
      'size': size,
      'noOfProduct': noOfProduct,
      'categoryType': categoryType,
    };
  }

  factory CartedModel.fromMap(Map<String, dynamic> map) {
    return CartedModel(
      cartedId: map['cartedId'] as String,
      productId: map['productId'] as String,
      image: map['image'] as String,
      productName: map['productName'] as String,
      price: map['price'] as String,
      size: map['size'] as String,
      noOfProduct: map['noOfProduct'] as String,
      categoryType: map['categoryType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartedModel.fromJson(String source) =>
      CartedModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartedModel(cartedId: $cartedId, productId: $productId, image: $image, productName: $productName, price: $price, size: $size, noOfProduct: $noOfProduct, categoryType: $categoryType)';
  }

  @override
  bool operator ==(covariant CartedModel other) {
    if (identical(this, other)) return true;

    return other.cartedId == cartedId &&
        other.productId == productId &&
        other.image == image &&
        other.productName == productName &&
        other.price == price &&
        other.size == size &&
        other.noOfProduct == noOfProduct &&
        other.categoryType == categoryType;
  }

  @override
  int get hashCode {
    return cartedId.hashCode ^
        productId.hashCode ^
        image.hashCode ^
        productName.hashCode ^
        price.hashCode ^
        size.hashCode ^
        noOfProduct.hashCode ^
        categoryType.hashCode;
  }
}
