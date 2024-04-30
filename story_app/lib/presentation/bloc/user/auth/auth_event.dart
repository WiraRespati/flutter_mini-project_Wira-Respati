import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthButtonPressed extends AuthEvent {
  @override
  List<Object?> get props => [];
}
class CheckLoginStatus extends AuthEvent {
  @override
  List<Object?> get props => [];
}
