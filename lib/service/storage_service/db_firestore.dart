import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/models/result_model.dart';
import 'package:ikea_store/service/storage_service/db_firestore_api.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DbFirestoreService implements DbApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  // final String _collectionUsers = 'users';
  final String _collectionProducts = 'products';
  final String _collectionCategories = 'category';
  final String _pathImages = 'images/';

  Future<String> _uploadFileToFirebaseStorage(File file) async {
    String downloadURL = '';
    try {
      final String? fileExist =
          await _checkFileExistInStorage("$_pathImages/${file.uri.pathSegments.last}");
      if (fileExist == null) {
        TaskSnapshot taskSnapshot = await _firebaseStorage
            .ref()
            .child("$_pathImages/${file.uri.pathSegments.last}")
            .putFile(file);
        downloadURL = await taskSnapshot.ref.getDownloadURL();
      } else {
        downloadURL = fileExist;
      }
    } catch (e) {}
    return downloadURL;
  }

  Future<String?> _checkFileExistInStorage(String filePath) async {
    try {
      Reference reference = _firebaseStorage.ref().child(filePath);
      final fileExists = await reference.getDownloadURL();
      return fileExists;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Result> addCategory(CategoryModel category, File imageFile) async {
    try {
      String downloadUrl = await _uploadFileToFirebaseStorage(imageFile);
      await _firestore
          .collection(_collectionCategories)
          .doc(category.id)
          .set(category.copyWith(imageUrl: downloadUrl).toJson());
      return Result.success(null);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<Result> addProduct(ProductModel product, File imageFile) async {
    try {
      final imageUrl = await _uploadFileToFirebaseStorage(imageFile);
      await _firestore
          .collection(_collectionProducts)
          .doc(product.id)
          .set(product.copyWith(imageUrl: imageUrl).toJson());
      return Result.success(null);
    } on FirebaseException catch (error) {
      try {
        if (error.code == 'object-not-found') {}
        return Result.success(null);
      } catch (e) {
        return Result.fail(e.toString());
      }
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<Result> deleteCategory(CategoryModel category) async {
    try {
      await _firestore.collection(_collectionCategories).doc(category.id).delete();
      return Result.success(null);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<Result> deleteProduct(ProductModel product) async {
    try {
      await _firestore.collection(_collectionProducts).doc(product.id).delete();
      return Result.success(null);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Stream<List<CategoryModel>> getCategoryList() {
    return _firestore
        .collection(_collectionCategories)
        .snapshots()
        .map((event) => event.docs.map((e) => CategoryModel.fromJson(e.data())).toList());
  }

  @override
  Stream<List<ProductModel>> getProductList() {
    return _firestore
        .collection(_collectionProducts)
        .snapshots()
        .map((event) => event.docs.map((e) => ProductModel.fromJson(e.data())).toList());
  }

  @override
  Stream<Result<List<ProductModel>>> getProductsByCategory(CategoryModel category) async* {
    try {
      final products = _firestore
          .collection(_collectionProducts)
          .snapshots()
          .map((event) => event.docs.map((e) => ProductModel.fromJson(e.data())).toList());
      yield Result.success(products);
    } catch (e) {
      yield Result.fail(e.toString());
    }
  }

  @override
  Future<Result> updateCategory(CategoryModel category, File? imageFile) async {
    try {
      if (imageFile != null) {
        String imageUrl = await _uploadFileToFirebaseStorage(imageFile);
        await _firestore
            .collection(_collectionCategories)
            .doc(category.id)
            .update(category.copyWith(imageUrl: imageUrl).toJson());
      } else {
        await _firestore
            .collection(_collectionCategories)
            .doc(category.id)
            .update(category.toJson());
      }
      // if (imageFile != null) {
      //   final snapshot = await _firebaseStorage
      //       .ref('$_pathImages/${imageFile.uri.pathSegments.last}')
      //       .putFile(imageFile);
      //   final downloadUrl = await snapshot.ref.getDownloadURL();
      // }
      // print([category.id]);
      // await _firestore.collection(_collectionCategories).doc(category.id).update(category.toJson());
      return Result.success(null);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<Result> updateProduct(ProductModel product, File? imageFile) async {
    try {
      if (imageFile != null) {
        String imageUrl = await _uploadFileToFirebaseStorage(imageFile);
        await _firestore
            .collection(_collectionProducts)
            .doc(product.id)
            .update(product.copyWith(imageUrl: imageUrl).toJson());
      } else {
        await _firestore.collection(_collectionProducts).doc(product.id).update(product.toJson());
      }

      return Result.success(null);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<Result<List<CategoryModel>>> getCategoriesListSingle() async {
    try {
      final query = await _firestore.collection(_collectionCategories).get();
      final result = query.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
      return Result.success(result);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }
}
