// implements authrepository by delegating to authremotedatasource
// this is the single place where firebase is wired to the domain layer

import 'package:minito/features/auth/data/auth_remote_datasource.dart';
import 'package:minito/features/auth/domain/auth_repository.dart';
import 'package:minito/features/auth/domain/models/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthRemoteDatasource _dataSource;

  @override
  Stream<AppUser?> get authStateChanges => _dataSource.authStateChanges;

  @override
  AppUser? get currentUser => _dataSource.currentUser;

  @override
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) => _dataSource.signInWithEmail(email: email, password: password);

  @override
  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) => _dataSource.signUpWithEmail(
    email: email,
    password: password,
    displayName: displayName,
  );

  @override
  Future<AppUser> signInWithGoogle() => _dataSource.signInWithGoogle();

  @override
  Future<void> signOut() => _dataSource.signOut();

  @override
  Future<void> sendPasswordReset(String email) =>
      _dataSource.sendPasswordReset(email);

  @override
  Future<void> updateDisplayName(String name) =>
      _dataSource.updateDisplayName(name);

  @override
  Future<void> deleteAccount() => _dataSource.deleteAccount();
}
