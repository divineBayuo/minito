// wraps firebaseauth into domain-friendly calls
// converts firebase errors to typed authexceptions

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minito/core/errors/exceptions.dart';
import 'package:minito/features/auth/domain/models/user.dart';

class AuthRemoteDatasource {
  AuthRemoteDatasource({FirebaseAuth? auth, GoogleSignIn? googleSignIn})
    : _auth = auth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn();

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  Stream<AppUser?> get authStateChanges =>
      _auth.authStateChanges().map(_mapUser);

  AppUser? get currentUser => _mapUser(_auth.currentUser);

  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapUser(cred.user)!;
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? e.code);
    }
  }

  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (displayName != null) {
        await cred.user?.updateDisplayName(displayName);
        await cred.user?.reload();
      }
      return _mapUser(_auth.currentUser)!;
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? e.code);
    }
  }

  Future<AppUser> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthException(message: 'Google sign-in cancelled.');
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final cred = await _auth.signInWithCredential(credential);
      return _mapUser(cred.user)!;
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? e.code);
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? e.code);
    }
  }

  // mapping
  AppUser? _mapUser(User? user) {
    if (user == null) return null;
    return AppUser(
      id: user.uid,
      email: user.email ?? '',
      photoUrl: user.photoURL,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
    );
  }
}
