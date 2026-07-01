// infrastructure providers
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_riverpod/legacy.dart';
import 'package:minito/features/auth/data/auth_remote_datasource.dart';
import 'package:minito/features/auth/data/auth_repository_impl.dart';
import 'package:minito/features/auth/domain/auth_repository.dart';
import 'package:minito/features/auth/domain/models/user.dart';

final authDataSourceProvider = Provider<AuthRemoteDatasource>(
  (_) => AuthRemoteDatasource(),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(authDataSourceProvider)),
);

// auth state
// hold the full auth state (loading/authenticated/unauthenticated)
class AuthState {
  final AppUser? user;
  final bool isLoading;
  final String? error;

  const AuthState({this.user, this.isLoading = false, this.error});

  bool get isLoggedIn => user != null;

  AuthState copyWith({
    AppUser? user,
    bool clearUser = false,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// the main auth notifier, listens to firebase auth state changes
// and exposes sign in/sign up/sign out actions to the UI
class AuthNotifier extends Notifier<AuthState> {
  StreamSubscription<AppUser?>? _authSub;

  @override
  AuthState build() {
    final repo = ref.watch(authRepositoryProvider);

    // cancel any previous sub when provider rebuilds
    _authSub?.cancel();

    // listen to FIrebase auth state
    _authSub = repo.authStateChanges.listen((user) {
      state = AuthState(user: user);
    });

    // clean up when provider is disposed
    ref.onDispose(() => _authSub?.cancel());

    return const AuthState(isLoading: true);
  }

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _repo.signInWithEmail(
        email: email,
        password: password,
      );
      state = AuthState(user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _repo.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
      state = AuthState(user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _repo.signInWithGoogle();
      state = AuthState(user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
    state = const AuthState();
  }

  // Add these three methods inside AuthNotifier:

Future<void> updateDisplayName(String name) async {
  try {
    await _repo.updateDisplayName(name);
  } catch (e) {
    state = state.copyWith(error: e.toString());
  }
}

Future<void> sendPasswordReset(String email) async {
  try {
    await _repo.sendPasswordReset(email);
  } catch (e) {
    state = state.copyWith(error: e.toString());
  }
}

Future<void> deleteAccount() async {
  try {
    await _repo.deleteAccount();
    state = const AuthState();
  } catch (e) {
    state = state.copyWith(error: e.toString());
  }
}
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

// convenient provider which returns only the current appuser or null
final currentUserProvider = Provider<AppUser?>(
  (ref) => ref.watch(authProvider).user,
);
