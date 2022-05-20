import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return 'wrong-password';
      } else {
        return e.message.toString();
      }
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  //login with google
  Future<String> signInWithGoogle() async {
    try {
      //Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      //Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      //create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      //Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      return 'Signed In';
    } catch (e) {
      return e.toString();
    }
  }
}
