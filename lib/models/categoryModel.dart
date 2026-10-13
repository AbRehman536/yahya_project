// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  final String? docId;
  final String? categoryName;
  final String? categoryImage;
  final int? createdAt;

  CategoryModel({
    this.docId,
    this.categoryName,
    this.categoryImage,
    this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    docId: json["docId"],
    categoryName: json["categoryName"],
    categoryImage: json["categoryImage"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "docId": docId,
    "categoryName": categoryName,
    "categoryImage": categoryImage,
    "createdAt": createdAt,
  };
}
