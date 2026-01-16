import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Stream to listen to login/logout
  static Stream<User?> authState() {
    return _auth.authStateChanges();
  }

  /// Currently logged-in user
  static User? get currentUser {
    return _auth.currentUser;
  }

  /// Sign in existing user
  static Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Create new user
  static Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Logout
  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
