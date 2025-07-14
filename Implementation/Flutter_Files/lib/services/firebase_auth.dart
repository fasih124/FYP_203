import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up with Email & Password
  // Future<User?> signUp(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return userCredential.user; // Returns the registered user
  //   } catch (e) {
  //     print("Sign-up Error: $e");
  //     return null;
  //   }
  // }

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification(); // 🔔 Send email verification
      }

      return user;
    } catch (e) {
      print("Sign-up Error: $e");
      return null;
    }
  }


  // Sign in with Email & Password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Returns the signed-in user
    } catch (e) {
      print("Sign-in Error: $e");
      return null;
    }
  }

  // Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
    print("User signed out");
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }


  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Password reset email sent");
    } catch (e) {
      print("Reset Password Error: $e");
    }
  }


}

