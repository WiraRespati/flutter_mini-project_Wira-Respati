import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/presentation/bloc/user/profile/profile_event.dart';
import 'package:story_app/presentation/bloc/user/profile/profile_state.dart';

import '../../../../data/repositories/user_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc(this.userRepository) : super(ProfileInitial()) {
    on<ProfileButtonPressed>(_onProfileButtonPressed);
  }

  void _onProfileButtonPressed(
      ProfileButtonPressed event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
     final userData =  await userRepository.getUser();
      emit(ProfileSuccess(user: userData));
    } catch (error) {
      emit(ProfileFailure(error: error.toString()));
    }
  }
}
