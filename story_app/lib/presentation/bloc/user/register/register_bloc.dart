import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/presentation/bloc/user/register/register_event.dart';
import 'package:story_app/presentation/bloc/user/register/register_state.dart';

import '../../../../data/repositories/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterBloc(this.userRepository) : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  void _onRegisterButtonPressed(RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      await userRepository.register(event.registerModel);
      emit(RegisterSuccess());
    } catch (error) {
      emit(RegisterFailure(error: error.toString()));
    }
  }
}
