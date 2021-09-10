import 'package:bebkeler/infrastructure/auth/apple_identity_provider.dart';
import 'package:bebkeler/infrastructure/auth/google_identity_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppUser {
  final String id;
  final String email;
  final String displayName;

  AppUser({this.id, this.email, this.displayName});
}

enum SignInProvider { google, apple }

abstract class IdentityProvider {
  Future signIn();
  Future signOut();
}

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  bool get isAuthenticated => currentUser != null;
  AppUser get currentUser => _mapUser(_firebaseAuth.currentUser);

  Future signIn(SignInProvider provider) {
    if (isAuthenticated) return Future.value();

    final authProvider = _selectProvider(provider);
    return authProvider.signIn();
  }

  Future signOut() {
    if (!isAuthenticated) return Future.value();

    final authProvider = _getCurrentProvider();
    return authProvider.signOut();
  }

  static AuthService get instance => AuthService(FirebaseAuth.instance);

  IdentityProvider _selectProvider(SignInProvider provider) {
    switch (provider) {
      case SignInProvider.google:
        return GoogleIdentityProvider(_firebaseAuth, GoogleSignIn());
      case SignInProvider.apple:
        return AppleIdentityProvider(_firebaseAuth);
    }
  }

  IdentityProvider _getCurrentProvider() {
    final providerId = _firebaseAuth.currentUser.providerData[0].providerId;
    switch (providerId) {
      case 'google.com':
        return GoogleIdentityProvider(_firebaseAuth, GoogleSignIn());
      case 'apple.com':
        return AppleIdentityProvider(_firebaseAuth);
    }
  }

  AppUser _mapUser(User user) {
    return user != null
        ? AppUser(id: user.uid, email: user.email, displayName: user.displayName)
        : null;
  }
}
