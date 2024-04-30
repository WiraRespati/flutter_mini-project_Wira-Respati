import 'package:equatable/equatable.dart';
import 'package:story_app/data/models/user/login_request_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends LoginEvent {
   final LoginRequestModel loginModel;

  const LoginButtonPressed(this.loginModel);

  @override
  List<Object?> get props => [loginModel];
}
