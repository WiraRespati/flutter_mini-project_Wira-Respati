import 'package:equatable/equatable.dart';

import '../../../../data/models/user/register_request_model.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final RegisterRequestModel registerModel;

  const RegisterButtonPressed(this.registerModel);

  @override
  List<Object?> get props => [registerModel];
}
