import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthApiProvider {
  
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<(String? token, String? error)> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var authResult = await auth.signInWithCredential(credential);

      var user = authResult.user;

      String? userToken = await user!.getIdToken();

      if (userToken != null) {
        return (userToken, null);
      } else {
        return (null, "somthings went wrong...");
      }
    } on Exception catch (e) {
      return (null, e.toString());
    }
  }

  Future<(String? token, String? error)> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      User? user = userCredential.user;
      if (user != null) {
        String? userToken = await user.getIdToken();
        return (userToken, null);
      } else {
        return (null, "somthings went wrong...");
      }
    } catch (e) {
      print("Error: $e");
      return (null, e.toString());
    }
  }
}
