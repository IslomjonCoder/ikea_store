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
  final String _collectionUsers = 'users';
  final String _collectionProducts = 'products';
  final String _collectionCategories = 'category';
  final String _pathImages = 'images/';

  @override
  Future<Result> addCategory(CategoryModel category, File imageFile) async {
    try {
      final List results = await Future.wait([
        _firebaseStorage.ref('$_pathImages/${imageFile.uri.pathSegments.last}').putFile(imageFile),
        _firestore.collection(_collectionCategories).add(category.toJson())
      ].whereType<Future<void>>().toList());
      TaskSnapshot newFile = results[0];
      DocumentReference newCategory = results[1];
      // await _firebaseStorage.ref('$_pathImages/${imageFile.path}').putFile(imageFile);
      final String downloadUrl = await newFile.ref.getDownloadURL();
      // await _firestore.collection(_collectionCategories).add(category.toJson());
      await _firestore
          .collection(_collectionCategories)
          .doc(newCategory.id)
          .update(category.copyWith(id: newCategory.id, imageUrl: downloadUrl).toJson());
      // .update({"id": newCategory.id});
      return Result.success(null);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<Result> addProduct(ProductModel product, File? imageFile) async {
    try {
      final List results = await Future.wait([
        _firebaseStorage
            .ref('$_pathImages/${imageFile?.uri.pathSegments.last}')
            .putFile(imageFile!),
        _firestore.collection(_collectionProducts).add(product.toJson())
      ].whereType<Future<void>>().toList());
      TaskSnapshot newFile = results[0];
      DocumentReference newCategory = results[1];
      final String downloadUrl = await newFile.ref.getDownloadURL();
      await _firestore
          .collection(_collectionProducts)
          .doc(newCategory.id)
          .update(product.copyWith(imageUrl: downloadUrl).toJson());
      return Result.success(null);
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
      await _firestore.collection(_collectionCategories).doc(product.id).delete();
      return Result.success(null);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Stream<Result<List<CategoryModel>>> getCategoryList() {
    return _firestore.collection(_collectionCategories).snapshots().map((event) {
      try {
        List<CategoryModel> categoryDocs =
            event.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
        return Result.success(categoryDocs);
      } catch (e) {
        return Result.fail(e.toString());
      }
    });
  }

  @override
  Stream<Result<List<ProductModel>>> getProductList() {
    return _firestore.collection(_collectionProducts).snapshots().map((event) {
      try {
        List<ProductModel> categoryDocs =
            event.docs.map((e) => ProductModel.fromJson(e.data())).toList();
        return Result.success(categoryDocs);
      } catch (e) {
        return Result.fail(e.toString());
      }
    });
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
        final snapshot = await _firebaseStorage
            .ref('$_pathImages/${imageFile.uri.pathSegments.last}')
            .putFile(imageFile);
        final downloadUrl = await snapshot.ref.getDownloadURL();
      }
      print([category.id]);
      await _firestore.collection(_collectionCategories).doc(category.id).update(category.toJson());
      return Result.success(null);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  @override
  Future<Result> updateProduct(ProductModel product) async {
    try {
      await _firestore.collection(_collectionCategories).doc(product.id).update(product.toJson());
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
      print(result);
      return Result.success(result);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }
}
