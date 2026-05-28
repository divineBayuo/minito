// infrastructure providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
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

  AuthState copyWith({AppUser? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// the main auth notifier, listens to firebase auth state changes
// and exposes sign in/sign up/sign out actions to the UI
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._repo) : super(const AuthState(isLoading: true)) {
    // subscribe to the auth state stream immediately
    _repo.authStateChanges.listen((user) {
      state = AuthState(user: user);
    });
  }

  final AuthRepository _repo;

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
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(authRepositoryProvider)),
);

// convenient provider which returns only the current appuser or null
final currentUserProvider = Provider<AppUser?>(
  (ref) => ref.watch(authProvider).user,
);
