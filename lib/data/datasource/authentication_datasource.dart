import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gforce/data/repository/authentication_firebase_provider.dart';

class AuthDataSource {
  final AuthenticationFirebaseProvider _authProvider;

  AuthDataSource(this._authProvider);

  Future<UserCredential> signIn(String email, String password) async {
    return await _authProvider.signInWithEmailAndPassword(email, password);
  }

  Future<UserCredential> signUp(
      String name, String email, String password, String country) async {
    return await _authProvider.signUp(name, email, password, country);
  }

  Future<void> signOut() async {
    return await _authProvider.signOut();
  }
}
