// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductModel {
  String? venderUid;
  String? productUid;
  bool? publish;
  String? productName;
  String? price;
  String? fashionCategory;
  String? gender;
  String? fashionItem;
  String? keyFeatures;
  String? description;
  List<String>? sizes;
  List<String> images; // Added list of images
  ProductModel({
    this.venderUid,
    this.productUid,
    this.publish,
    this.productName,
    this.price,
    this.fashionCategory,
    this.gender,
    this.fashionItem,
    this.keyFeatures,
    this.description,
    this.sizes,
    required this.images,
  });

  ProductModel copyWith({
    String? venderUid,
    String? productUid,
    bool? publish,
    String? productName,
    String? price,
    String? fashionCategory,
    String? gender,
    String? fashionItem,
    String? keyFeatures,
    String? description,
    List<String>? sizes,
    List<String>? images,
  }) {
    return ProductModel(
      venderUid: venderUid ?? this.venderUid,
      productUid: productUid ?? this.productUid,
      publish: publish ?? this.publish,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      fashionCategory: fashionCategory ?? this.fashionCategory,
      gender: gender ?? this.gender,
      fashionItem: fashionItem ?? this.fashionItem,
      keyFeatures: keyFeatures ?? this.keyFeatures,
      description: description ?? this.description,
      sizes: sizes ?? this.sizes,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'venderUid': venderUid,
      'productUid': productUid,
      'publish': publish,
      'productName': productName,
      'price': price,
      'fashionCategory': fashionCategory,
      'gender': gender,
      'fashionItem': fashionItem,
      'keyFeatures': keyFeatures,
      'description': description,
      'sizes': sizes,
      'images': images,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      venderUid: map['venderUid'] != null ? map['venderUid'] as String : null,
      productUid:
          map['productUid'] != null ? map['productUid'] as String : null,
      publish: map['publish'] != null ? map['publish'] as bool : null,
      productName:
          map['productName'] != null ? map['productName'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      fashionCategory: map['fashionCategory'] != null
          ? map['fashionCategory'] as String
          : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      fashionItem:
          map['fashionItem'] != null ? map['fashionItem'] as String : null,
      keyFeatures:
          map['keyFeatures'] != null ? map['keyFeatures'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      sizes: List<String>.from(map['sizes'] ?? []),
      images: List<String>.from(map['images'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(venderUid: $venderUid, productUid: $productUid, publish: $publish, productName: $productName, price: $price, fashionCategory: $fashionCategory, gender: $gender, fashionItem: $fashionItem, keyFeatures: $keyFeatures, description: $description, sizes: $sizes, images: $images)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.venderUid == venderUid &&
        other.productUid == productUid &&
        other.publish == publish &&
        other.productName == productName &&
        other.price == price &&
        other.fashionCategory == fashionCategory &&
        other.gender == gender &&
        other.fashionItem == fashionItem &&
        other.keyFeatures == keyFeatures &&
        other.description == description &&
        listEquals(other.sizes, sizes) &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return venderUid.hashCode ^
        productUid.hashCode ^
        publish.hashCode ^
        productName.hashCode ^
        price.hashCode ^
        fashionCategory.hashCode ^
        gender.hashCode ^
        fashionItem.hashCode ^
        keyFeatures.hashCode ^
        description.hashCode ^
        sizes.hashCode ^
        images.hashCode;
  }
}
