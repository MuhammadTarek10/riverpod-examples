
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tinstgrame/state/auth/constants/constants.dart';
import 'package:tinstgrame/state/auth/models/auth_result.dart';
import 'package:tinstgrame/state/posts/typedef/user_id.dart';




class Authenticator {
  const Authenticator();

  User? get user => FirebaseAuth.instance.currentUser;
  UserId? get userId => user?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName => user?.displayName ?? '';
  String? get email => user?.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    // await FacebookAuth.instance.logOut();
  }

  Future<AuthResults> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;
    if (token == null) {
      // User aborted login
      return AuthResults.aborted;
    }
    final credential = FacebookAuthProvider.credential(token);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      return AuthResults.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credentials = e.credential;
      if (e.code == Constants.accountExistingWithDifferentCredentials &&
          email != null &&
          credentials != null) {
        final provider =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (provider.contains(Constants.googleCom)) {
          await loginWithGoogle();
          user?.linkWithCredential(credentials);
          return AuthResults.success;
        }
        return AuthResults.failure;
      }
      return AuthResults.failure;
    }
  }

  Future<AuthResults> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      Constants.emailScope,
    ]);
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      // User aborted login
      return AuthResults.aborted;
    }
    final googleAuth = await googleUser.authentication;
    final credentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credentials);
      return AuthResults.success;
    } on FirebaseAuthException catch (_) {
      return AuthResults.failure;
    }
  }
}
