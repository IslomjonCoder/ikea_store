import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/models/result_model.dart';
import 'package:ikea_store/models/review_model.dart';
import 'package:ikea_store/service/storage_service/db_firestore_api.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DbFirestoreService implements DbApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // final String _collectionUsers = 'users';
  final String _collectionProducts = 'products';
  final String _collectionCategories = 'category';
  final String _collectionOrders = 'order';
  final String _collectionCart = 'cart';
  final String _collectionReview = 'review';
  final String _pathImages = 'images/';

  Future<String> _uploadFileToFirebaseStorage(File file) async {
    String path = "$_pathImages/${file.uri.pathSegments.last}";
    String downloadURL = '';
    try {
      final String? fileExist = await _checkFileExistInStorage(path);
      if (fileExist == null) {
        TaskSnapshot taskSnapshot = await _firebaseStorage.ref().child(path).putFile(file);
        downloadURL = await taskSnapshot.ref.getDownloadURL();
      } else {
        downloadURL = fileExist;
      }
    } catch (e) {
      print(e);
    }
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

  // --------------------- Category -------------------------------------
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
  Future<Result> updateCategory(CategoryModel category, File? imageFile) async {
    try {
      if (imageFile != null) {
        String imageUrl = await _uploadFileToFirebaseStorage(imageFile);
        await _firestore
            .collection(_collectionCategories)
            .doc(category.id)
            .update(category.copyWith(imageUrl: imageUrl).toJson());
      } else {
        await _firestore.collection(_collectionCategories).doc(category.id).update(category.toJson());
      }
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

  // --------------------- Product -------------------------------------

  @override
  Future<Result> addProduct(ProductModel product, File imageFile) async {
    try {
      final imageUrl = await _uploadFileToFirebaseStorage(imageFile);
      await _firestore
          .collection(_collectionProducts)
          .doc(product.id)
          .set(product.copyWith(imageUrl: imageUrl).toJson());
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
  Future<Result> deleteProduct(ProductModel product) async {
    try {
      await _firestore.collection(_collectionProducts).doc(product.id).delete();
      return Result.success(null);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  // --------------------- Stream -------------------------------------

  @override
  Stream<List<CategoryModel>> getCategoryList() {
    return _firestore
        .collection(_collectionCategories)
        .snapshots()
        .map((event) => event.docs.map((e) => CategoryModel.fromJson(e.data())).toList());
  }

  @override
  Stream<List<ProductModel>> getProductList() {
    return _firestore.collection(_collectionProducts).snapshots().map((event) {
      return event.docs.map((e) {
        print(e.data());
        return ProductModel.fromJson(e.data());
      }).toList();
    });
  }

  // --------------------- Cart -------------------------------------

  @override
  Future<Result> addToCard({required String productID, required String userID, required int count}) async {
    try {
      await _firestore.collection(_collectionCart).doc(userID).update({productID: count});
      return Result.success(null);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  updateCartItemCount({required String userID, required String productID, required int count}) async {
    try {
      _firestore.collection(_collectionCart).doc(userID).update({productID: count});
      return Result.success(null);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }

  deleteCartItem({required String productId, required String userID}) {
    _firestore.collection(_collectionCart).doc(userID).set({productId: FieldValue.delete()}, SetOptions(merge: true));
  }

  addReview(ReviewModel review, ProductModel product) async {
    product.comments?.add(review);
    try {
      List<Map<String, dynamic>> reviews = product.comments?.map((e) => e.toJson()).toList() ?? [];
      reviews.add(review.toJson());

      await Future.wait([
        _firestore
            .collection(_collectionProducts)
            .doc(product.id)
            .update({'rating': (product.rating + review.rating) / 2}),
        _firestore.collection(_collectionProducts).doc(product.id).update({'review': reviews})
      ]);

      return Result.success(null);
    } catch (e) {
      return Result.fail(e.toString());
    }
  }
}
