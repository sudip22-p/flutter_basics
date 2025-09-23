import "package:firebase_auth/firebase_auth.dart";

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("sud User created successfully: ${userCredentials.user?.uid}");
    } on FirebaseAuthException catch (e) {
      // Re-throw the exception so it can be handled by the bloc
      throw FirebaseAuthException(
        code: e.code,
        message: e.message ?? "An unknown Firebase Auth error occurred",
      );
    } catch (e) {
      throw Exception("Failed to create user account: $e");
    }
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      print("sud User signed in successfully: ${userCredential.user?.uid}");
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.message ?? "An unknown Firebase Auth error occurred",
      );
    } catch (e) {
      throw Exception("Failed to sign in: $e");
    }
  }
}
