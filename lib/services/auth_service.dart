import 'package:firebase_auth/firebase_auth.dart';

import '../utils/constant.dart';
import '../utils/result_utils.dart';

class AuthService {
  AuthService._();

  static final AuthService _instance = AuthService._();

  static AuthService get instance => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Result<User?>> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Success(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Failure('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        return Failure('The account already exists for that email');
      }
      return Failure(Constant.TRY_AGAIN_MESSAGE);
    } catch (e) {
      print(e);
      return Failure(Constant.TRY_AGAIN_MESSAGE);
    }
  }

  Future<Result<User?>> logIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Success(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Failure('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return Failure('Wrong password provided for that user.');
      }
      return Failure(Constant.TRY_AGAIN_MESSAGE);
    } catch (e) {
      return Failure(Constant.TRY_AGAIN_MESSAGE);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }
}
