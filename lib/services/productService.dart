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
  ///Get Exclusive Product
  Stream<List<ProductModel>> getExclusiveProduct(){
    return FirebaseFirestore.instance
        .collection(ProductCollection)
        .where("exclusiveOffer", isEqualTo: true)
        .snapshots()
        .map((ProductList) => ProductList.docs
        .map((ProductJson) => ProductModel.fromJson(ProductJson.data()))
        .toList());
  }
  ///Mark Product
  Future<void> markExclusiveOffer(String docId, bool value) async {
    await FirebaseFirestore.instance
        .collection("Products")
        .doc(docId)
        .update({
      "exclusiveOffer": value,
    });
  }
  ///Get Best Selling Product
  Stream<List<ProductModel>> getBestSellingProduct(){
    return FirebaseFirestore.instance
        .collection(ProductCollection)
        .where("bestSelling", isEqualTo: true)
        .snapshots()
        .map((ProductList) => ProductList.docs
        .map((ProductJson) => ProductModel.fromJson(ProductJson.data()))
        .toList());
  }
  ///Mark Product
  Future<void> markBestProduct(String docId, bool value) async {
    await FirebaseFirestore.instance
        .collection("Products")
        .doc(docId)
        .update({
      "bestSelling": value,
    });
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
  ///Get My Cart Products
  Stream<List<ProductModel>> getMyCartProducts(String userID){
    return FirebaseFirestore.instance
        .collection(ProductCollection)
        .where("cart", arrayContains: userID)
        .snapshots()
        .map((ProductList) => ProductList.docs
        .map((ProductJson) => ProductModel.fromJson(ProductJson.data()))
        .toList());
  }
  ///Add to Cart
  Future addToCart({
    required String userID,
    required String productID,
})async{
    return await FirebaseFirestore.instance
        .collection(ProductCollection)
        .doc(productID)
        .update({"cart": FieldValue.arrayUnion([userID])});
  }
  ///Remove From Cart
  Future removeFromCart({
    required String userID,
    required String productID,
})async{
    return await FirebaseFirestore.instance
        .collection(ProductCollection)
        .doc(productID)
        .update({"cart": FieldValue.arrayRemove([userID])});
  }
  ///Get Favorite Products
  Stream<List<ProductModel>> getFavoriteProducts(String userID){
    return FirebaseFirestore.instance
        .collection(ProductCollection)
        .where("favorite", arrayContains: userID)
        .snapshots()
        .map((ProductList) => ProductList.docs
        .map((ProductJson) => ProductModel.fromJson(ProductJson.data()))
        .toList());
  }
  ///Add to favorite
  Future addToFavorite({
    required String userID,
    required String productID,
})async{
    return await FirebaseFirestore.instance
        .collection(ProductCollection)
        .doc(productID)
        .update({"favorite": FieldValue.arrayUnion([userID])});
  }
  ///Remove From Favorite
  Future removeFromFavorite({
    required String userID,
    required String productID,
})async{
    return await FirebaseFirestore.instance
        .collection(ProductCollection)
        .doc(productID)
        .update({"favorite": FieldValue.arrayRemove([userID])});
  }
}