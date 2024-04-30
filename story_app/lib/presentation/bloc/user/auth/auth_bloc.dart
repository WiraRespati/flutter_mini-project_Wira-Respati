import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc(this.userRepository) : super(AuthInitial()) {
    on<AuthButtonPressed>(_onAuthButtonPressed);
    on<CheckLoginStatus>(_onCheckLoginStatus);
  }

  void _onAuthButtonPressed(
      AuthButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await userRepository.deleteAuth();
      emit(AuthLogoutSuccess());
    } catch (error) {
      emit(AuthFailure(error: error.toString()));
    }
  }

  void _onCheckLoginStatus(
      CheckLoginStatus event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      bool isLoggedIn = await userRepository.isLogin();
      if (isLoggedIn) {
        emit(AuthSuccess()); // Emitted when logged in
      } else {
        emit(const AuthFailure(error: 'Not logged in'));
      }
    } catch (error) {
      emit(AuthFailure(error: error.toString()));
    }
  }
}

