import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yahya_project/models/categoryModel.dart';

class CategoryService {

  String categoryCollection = "Category Collection";

  ///Create Category
  Future createCategory(CategoryModel model)async{
    return await FirebaseFirestore.instance
        .collection(categoryCollection)
        .add(model.toJson());
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

}