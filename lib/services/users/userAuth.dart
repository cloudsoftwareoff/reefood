import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegistrationResult {
  final User? user;
  final String? error;

  RegistrationResult({this.user, this.error});
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Get User Instance
  dynamic getUID() {
    if (_auth.currentUser == null) {
      return null;
    }
    return _auth.currentUser?.uid;
  }

  String xerror = "Something went wrong";
  String errorMessage = "Registration failed. Please try again.";
  // Sign in with email and password
  Future<RegistrationResult?> signInWithEmailAndPassword(
      String email, String password) async {
    //print("started : $email");
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;
      print("success");
      return RegistrationResult(user: user, error: null);
    } catch (e) {
      print(e.toString());

      if (e is FirebaseAuthException) {
        xerror = getErrorMessage(e.code);
      }

      return RegistrationResult(user: null, error: xerror);
    }
  }

  // Register with email and password
  Future<RegistrationResult?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;
      return RegistrationResult(user: user, error: null);
    } catch (e) {
      if (e is FirebaseAuthException) {
        errorMessage = getErrorMessage(e.code);
      }

      return RegistrationResult(user: null, error: errorMessage);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the Google Authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Sign in to Firebase with the Google credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

String getErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'invalid-login-credentials':
      return 'Invalid password or Email';
    case 'wrong-password':
      return 'Invalid password. Please check your password and try again.';
    case 'invalid-email':
      return 'Invalid email address. Please provide a valid email.';
    case 'user-disabled':
      return 'Your account has been disabled. Please contact support.';
    case 'user-not-found':
      return 'User not found. Please check your email or sign up for an account.';
    case 'email-already-in-use':
      return 'An account with this email already exists. Please use a different email address.';
    case 'operation-not-allowed':
      return 'Email/password accounts are not enabled. Please contact support.';
    case 'weak-password':
      return 'The password is not strong enough. Please choose a stronger password.';
    default:
      return 'An unknown error occurred. Please try again later.';
  }
}
