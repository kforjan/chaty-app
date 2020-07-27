import 'package:firebase_auth/firebase_auth.dart';

class User {
  User({
    this.userId,
  });
  String userId;
}

abstract class AuthBase {
  Stream<User> get onAuthChanged;
  Future<User> register(String email, String password);
  Future<User> signIn(String email, String password);
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
      userId: user.uid,
    );
  }

  @override
  Stream<User> get onAuthChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      final _authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(_authResult.user);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<User> register(String email, String password) async {
    try {
      final _authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(_authResult.user);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
