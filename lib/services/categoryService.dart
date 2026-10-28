import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yahya_project/models/categoryModel.dart';

class CategoryService {

  String categoryCollection = "Category Collection";

  ///Create Category
  Future createCategory(CategoryModel model)async{
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection(categoryCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(categoryCollection)
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }
  ///Update Category
  Future updateCategory(CategoryModel model)async{
    return await FirebaseFirestore.instance
        .collection(categoryCollection)
        .doc(model.docId)
        .update({"categoryName" : model.categoryName,
      "categoryImage" : model.categoryImage});
  }
  ///Delete Category
  Future deleteCategory(String docId)async{
    return await FirebaseFirestore.instance
        .collection(categoryCollection)
        .doc(docId)
        .delete();
  }

  ///Get All Category
  Stream<List<CategoryModel>> getAllCategory(){
    return FirebaseFirestore.instance
        .collection(categoryCollection)
        .snapshots()
        .map((categoryList) => categoryList.docs
        .map((categoryJson) => CategoryModel.fromJson(categoryJson.data()))
    .toList());
  }
  ///Get Category
  Future<List<CategoryModel>> getCategory(){
    return FirebaseFirestore.instance
        .collection(categoryCollection)
        .get()
        .then((categoryList) => categoryList.docs
        .map((categoryJson) => CategoryModel.fromJson(categoryJson.data()))
    .toList());
  }
  ///Search Category
  Stream<List<CategoryModel>> searchCategory(String categoryName){
    return FirebaseFirestore.instance
        .collection(categoryCollection)
        .snapshots()
        .map((categoryList) => categoryList.docs
        .map((categoryJson) => CategoryModel.fromJson(categoryJson.data()))
        .where((category) => category.categoryName!.toLowerCase()
          .contains(categoryName.toLowerCase()))
        .toList());
  }
}