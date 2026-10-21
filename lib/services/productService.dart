import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';
class ProductService {

  String ProductCollection = "Product Collection";

  ///Create Product
  Future createProduct(ProductModel model)async{
    DocumentReference docRef = await FirebaseFirestore.instance
    .collection(ProductCollection)
    .doc();
    return await FirebaseFirestore.instance
        .collection(ProductCollection)
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }
  ///Update Product
  Future updateProduct(ProductModel model)async{
    return await FirebaseFirestore.instance
        .collection(ProductCollection)
        .doc(model.docId)
        .update({"productName" : model.productName,
      "productImage" : model.productImage, "productDetails" : model.productDetails,
      "productNutrition" : model.productNutrition,"productPrice" : model.productPrice,
      "productWeight" : model.productWeight});
  }
  ///Delete Product
  Future deleteProduct(String docId)async{
    return await FirebaseFirestore.instance
        .collection(ProductCollection)
        .doc(docId)
        .delete();
  }
  ///Mark Product
  Future markStockProduct(String productID, bool productStock)async{
    return await FirebaseFirestore.instance
        .collection(ProductCollection)
        .doc(productID)
        .update({"productStock" : productStock});
  }
  ///Get All Product
  Stream<List<ProductModel>> getAllProduct(){
    return FirebaseFirestore.instance
        .collection(ProductCollection)
        //.orderBy("createdAt" , descending: false )
        .snapshots()
        .map((ProductList) => ProductList.docs
        .map((ProductJson) => ProductModel.fromJson(ProductJson.data()))
        .toList());
  }
  ///Get In Stock Product
  Stream<List<ProductModel>> getInStockProduct(){
    return FirebaseFirestore.instance
        .collection(ProductCollection)
        .where("productStock", isEqualTo: true)
        .snapshots()
        .map((ProductList) => ProductList.docs
        .map((ProductJson) => ProductModel.fromJson(ProductJson.data()))
        .toList());
  }
  ///Get Out of Stock Product
  Stream<List<ProductModel>> getOutStockProduct(){
    return FirebaseFirestore.instance
        .collection(ProductCollection)
        .where("productStock", isEqualTo: false)
        .snapshots()
        .map((ProductList) => ProductList.docs
        .map((ProductJson) => ProductModel.fromJson(ProductJson.data()))
        .toList());
  }
  ///Get Products By Category ID
  Stream<List<ProductModel>> getProductsByCategoryID(String categoryID){
    return FirebaseFirestore.instance
        .collection(ProductCollection)
        .where("categoryID", isEqualTo: categoryID)
        .snapshots()
        .map((ProductList) => ProductList.docs
        .map((ProductJson) => ProductModel.fromJson(ProductJson.data()))
        .toList());
  }
}