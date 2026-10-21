// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

class CategoryModel {
  final String? docId;
  final String? categoryName;
  final String? categoryImage;
  final bool? stock;
  final int? createdAt;

  CategoryModel({
    this.docId,
    this.categoryName,
    this.categoryImage,
    this.stock,
    this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    docId: json["docId"],
    categoryName: json["categoryName"],
    categoryImage: json["categoryImage"],
    stock: json["stock"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String categoryID) => {
    "docId": categoryID,
    "categoryName": categoryName,
    "categoryImage": categoryImage,
    "stock": stock,
    "createdAt": createdAt,
  };
}
