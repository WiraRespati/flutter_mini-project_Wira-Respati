import 'package:equatable/equatable.dart';
import 'package:story_app/data/models/user/user_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserModel user;

  const ProfileSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}


class ProfileFailure extends ProfileState {
  final String error;

  const ProfileFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
