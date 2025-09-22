import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repo;
  StreamSubscription<User?>? _sub;

  AuthCubit(this._repo) : super(AuthInitial()) {
    _sub = _repo.authStateChanges.listen((user) {
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }
  void checkAuthStatus() {
  final user = _repo.getCurrentUser();
  if (user != null) {
    emit(AuthAuthenticated(user));
  } else {
    emit(AuthUnauthenticated());
  }
}


  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      await _repo.login(email: email, password: password);
      // on success the stream listener will emit AuthAuthenticated
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      emit(AuthLoading());
      await _repo.signUp(email: email, password: password);
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async => await _repo.logout();

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
