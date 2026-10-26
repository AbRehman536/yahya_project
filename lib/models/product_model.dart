// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

class ProductModel {
  final String? docId;
  final String? categoryID;
  final String? productImage;
  final String? productName;
  final String? productWeight;
  final double? productPrice;
  final String? productDetails;
  final int? productNutrition;
  final bool? productStock;
  final bool? bestSelling;
  final bool? exclusiveOffer;
  final List<dynamic>? cart;
  final List<dynamic>? favorite;
  final int? createdAt;

  ProductModel({
    this.docId,
    this.categoryID,
    this.productImage,
    this.productName,
    this.productWeight,
    this.productPrice,
    this.productDetails,
    this.productNutrition,
    this.cart,
    this.favorite,
    this.bestSelling,
    this.exclusiveOffer,
    this.productStock,
    this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    docId: json["docID"],
    categoryID: json["categoryID"],
    productImage: json["productImage"],
    productName: json["productName"],
    productWeight: json["productWeight"],
    productPrice: json["productPrice"],
    productDetails: json["productDetails"],
    productNutrition: json["productNutrition"],
    productStock: json["productStock"],
    bestSelling: json["bestSelling"],
    exclusiveOffer: json["exclusiveOffer"],
    cart: json["cart"] == null ? [] : List<dynamic>.from(json["cart"]!.map((x) => x)),
    favorite: json["favorite"] == null ? [] : List<dynamic>.from(json["favorite"]!.map((x) => x)),
    createdAt: json["createdAT"],
  );

  Map<String, dynamic> toJson(String productID) => {
    "docID": productID,
    "categoryID": categoryID,
    "productImage": productImage,
    "productName": productName,
    "productWeight": productWeight,
    "productPrice": productPrice,
    "productDetails": productDetails,
    "productNutrition": productNutrition,
    "productStock": productStock,
    "bestSelling": bestSelling,
    "exclusiveOffer": exclusiveOffer,
    "cart": cart == null ? [] : List<dynamic>.from(cart!.map((x) => x)),
    "favorite": favorite == null ? [] : List<dynamic>.from(favorite!.map((x) => x)),
    "createdAT": createdAt,
  };
}
