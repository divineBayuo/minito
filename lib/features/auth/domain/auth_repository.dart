// contract that any auth implementation must satisfy
// decouples the domain/presentation layers from firebase
import 'package:minito/features/auth/domain/models/user.dart';

abstract class AuthRepository {
  // stream that emits the current user (null when signed out)
  Stream<AppUser?> get authStateChanges;

  // return the currently cached user, or null
  AppUser? get currentUser;

  // signs in with email and password
  // throws authexception on failure
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  });

  // create a new account and returns the signed-in user
  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  // signs in with the platform Google account
  Future<AppUser> signInWithGoogle();

  // signs the current user out and clears the session
  Future<void> signOut();

  // sends a password-reset email to email
  Future<void> sendPasswordReset(String email);
}
