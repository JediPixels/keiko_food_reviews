import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  // Check users auth state changes via Stream
  static Stream<User?> get userAuthStateChanges =>
      FirebaseAuth.instance.authStateChanges();

  static String getCurrentUserUid() => FirebaseAuth.instance.currentUser!.uid;

  static Future<String?> createUserWithEmailAndPassword(
      {required String email, required String password}) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredentials) => userCredentials.user?.uid)
        .onError((FirebaseAuthException error, stackTrace) =>
          Future.error(error.code));
  }

  static Future<String?> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredentials) => userCredentials.user?.uid)
        .onError((FirebaseAuthException error, stackTrace) =>
          Future.error(error.code));
  }

  static Future<bool> sendPasswordReset(String email) {
    return FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }

  static Future<void> sendEmailVerification() async {
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
  }

  static Future<bool?> isEmailVerified() async {
    return FirebaseAuth.instance.currentUser?.emailVerified;
  }

  static Future<void> signOut() => FirebaseAuth.instance.signOut();
}