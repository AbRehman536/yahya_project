// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final String? docId;
  final String? productImage;
  final String? productName;
  final int? productWeight;
  final int? productPrice;
  final String? productDetails;
  final int? productNutrition;
  final bool? productStock;
  final int? createdAt;

  ProductModel({
    this.docId,
    this.productImage,
    this.productName,
    this.productWeight,
    this.productPrice,
    this.productDetails,
    this.productNutrition,
    this.productStock,
    this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    docId: json["docID"],
    productImage: json["productImage"],
    productName: json["productName"],
    productWeight: json["productWeight"],
    productPrice: json["productPrice"],
    productDetails: json["productDetails"],
    productNutrition: json["productNutrition"],
    productStock: json["productStock"],
    createdAt: json["createdAT"],
  );

  Map<String, dynamic> toJson() => {
    "docID": docId,
    "productImage": productImage,
    "productName": productName,
    "productWeight": productWeight,
    "productPrice": productPrice,
    "productDetails": productDetails,
    "productNutrition": productNutrition,
    "productStock": productStock,
    "createdAT": createdAt,
  };
}
