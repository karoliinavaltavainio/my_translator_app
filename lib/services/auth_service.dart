import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    // Step 1: Trigger the Google Sign-In flow (the popup or prompt)
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // The user canceled the sign-in
      throw Exception('User canceled Google Sign-In');
    }

    // Step 2: Retrieve the Google sign-in details
    final googleAuth = await googleUser.authentication;

    // Step 3: Create a new credential for Firebase
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Step 4: Sign in to Firebase with the credential
    return await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    // Sign out of Firebase
    await _auth.signOut();

    // (Optional) Sign out of Google as well
    // This ensures the next time you try signInWithGoogle(), it prompts again.
    await _googleSignIn.signOut();
  }
}
