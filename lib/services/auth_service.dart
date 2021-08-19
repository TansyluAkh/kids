import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bebkeler/models/user.dart' as models;
import 'package:bebkeler/services/database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // !Setup User object based on FirebaseUser object
  models.User _userFromFirebaseUser(User user) {
    return user != null
        ? models.User(uid: user.uid, displayName: user.displayName)
        : null;
  }

  // !Stream to notify auth changes
  Stream<models.User> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // !Sign in with Google Account
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user;

      await DatabaseService(uid: user.uid).updateSBSettings(1, 5);
      await DatabaseService(uid: user.uid)
          .updateSbGameData(user.displayName, 0, 0, 0.0);

      await DatabaseService(uid: user.uid)
          .updateMnSettings(1, 5, true, false, false, false);
      await DatabaseService(uid: user.uid)
          .updateMnGameData(user.displayName, 0, 0, 0.0);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
    }
  }

  // !Signout
  Future signOut() async {
    try {
      return await googleSignIn.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
