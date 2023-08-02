import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ikea_store/models/result_model.dart';
import 'package:ikea_store/service/auth_service/auth_exception_handler.dart';
import 'package:ikea_store/service/auth_service/authentication_api.dart';

class AuthenticationService implements AuthenticationApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionUsers = 'users';

  @override
  Future<Result> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return Result.success(null);
    } on FirebaseAuthException catch (error) {
      return Result.fail(AuthExceptionHandler.handleException(error.code));
    } catch (e) {
      return Result.fail(AuthExceptionHandler.handleException(e.toString()));
    }
  }

  @override
  Future<Result> logout() async {
    try {
      await _auth.signOut();
      return Result.success(null);
    } on FirebaseAuthException catch (error) {
      return Result.fail(AuthExceptionHandler.handleException(error.code));
    } catch (e) {
      return Result.fail(AuthExceptionHandler.handleException(e.toString()));
    }
  }

  @override
  Future<Result> createUserWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential newUser =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = newUser.user!;
      final snapshot = await _firestore.collection(_collectionUsers).doc(user.uid).get();
      if (!snapshot.exists) {
        await Future.wait([
          user.updateDisplayName(username),
          _firestore.collection(_collectionUsers).doc(user.uid).set({
            "id": user.uid,
            'email': user.email,
            'phone_number': user.phoneNumber,
            'photo_url': user.photoURL,
            "created_at": user.metadata.creationTime,
            'username': username,
          })
        ].whereType<Future<void>>().toList());
      }
      return Result.success(null);
    } on FirebaseAuthException catch (error) {
      return Result.fail(AuthExceptionHandler.handleException(error.code));
    } catch (e) {
      return Result.fail(AuthExceptionHandler.handleException(e.toString()));
    }
  }

  @override
  Future<Result> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential newUser = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = newUser.user!;
      final snapshot = await _firestore.collection(_collectionUsers).doc(user.uid).get();
      if (!snapshot.exists) {
        await _firestore.collection(_collectionUsers).doc(user.uid).set(
          {
            "id": user.uid,
            'email': user.email,
            'phone_number': user.phoneNumber,
            'photo_url': user.photoURL,
            "created_at": user.metadata.creationTime,
            'username': user.displayName,
          },
        );
      }
      return Result.success(null);
    } on FirebaseAuthException catch (error) {
      return Result.fail(AuthExceptionHandler.handleException(error.code));
    } catch (e) {
      return Result.fail(AuthExceptionHandler.handleException(e.toString()));
    }
  }

  @override
  Future<Result> updateUserInfo(String newUsername, String newEmail) async {
    try {
      print(_auth.currentUser?.displayName ?? 'Empty');
      await Future.wait([
        _auth.currentUser?.updateEmail(newEmail),
        _auth.currentUser?.updateDisplayName(newUsername)
      ].whereType<Future<void>>().toList());

      return Result.success(null);
    } on FirebaseAuthException catch (error) {
      return Result.fail(AuthExceptionHandler.handleException(error.code));
    } catch (e) {
      return Result.fail(AuthExceptionHandler.handleException(e.toString()));
    }
  }
}
