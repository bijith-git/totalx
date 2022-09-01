import 'package:totalx/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart ' as auth;

class AuthProvider {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  UserDetails? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    } else {
      return UserDetails(email: user.email!, uid: user.uid);
    }
  }

  Stream<UserDetails?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future createAccount(String email, String passwrd) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: passwrd);

      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (e) {
      return e.message;
    } catch (err) {
      rethrow;
    }
  }

  Future signInAccount(String email, String passwrd) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: passwrd);

      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (e) {
      return e.message;
    } catch (err) {
      rethrow;
    }
  }

  Future<String?> signOutAccount() async {
    try {
      await _firebaseAuth.signOut();
      return 'success';
    } on auth.FirebaseAuthException catch (e) {
      return e.message;
    } catch (err) {
      rethrow;
    }
  }

}
