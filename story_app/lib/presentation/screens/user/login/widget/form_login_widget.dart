import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/models/user/login_request_model.dart';
import 'package:story_app/presentation/bloc/user/login/login_event.dart';

import '../../../../../utils/constant/name_routes.dart';
import '../../../../../utils/constant/validation.dart';
import '../../../../bloc/user/login/login_bloc.dart';
import '../../../../bloc/user/login/login_state.dart';
import '../../../../widgets/button_global_widget.dart';
import '../../../../widgets/show_dialog_widget.dart';
import '../../../../widgets/text_field_input.dart';

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({super.key});

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();


  String? _emailErrorText;
  String? _passwordErrorText;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldInput(
          textEditingController: _emailController,
          textInputType: TextInputType.emailAddress,
          hintText: "Enter Your email",
          errorText: _emailErrorText,
          onChange: (value) {
            setState(() {
              _emailErrorText = Validation.validateEmail(value);
            });
          },
          isPass: false,
          focusNode: _emailFocusNode,
        ),
        const SizedBox(
          height: 24,
        ),
        TextFieldInput(
          textEditingController: _passwordController,
          textInputType: TextInputType.text,
          hintText: "Enter Your password",
          isPass: true,
          errorText: _passwordErrorText,
          onChange: (value) {
            setState(() {
              _passwordErrorText = Validation.validatePassword(value);
            });
          },
          focusNode: _passwordFocusNode,
        ),
        const SizedBox(
          height: 24,
        ),
        BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(context, NameRoutes.navigationPageRoute);
            } else if (state is LoginFailure) {
              ShowDialogWidget.showErrorDialog(
                context: context,
                title: 'Login Failed',
                message: state.error,
              );
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return const ButtonGlobalWidget(
                title: SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.0,
                  ),
                ),
              );
            } else {
              return ButtonGlobalWidget(
                title: const Text('Login'),
                onTap: () {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  _emailErrorText = Validation.validateEmail(email);
                  _passwordErrorText = Validation.validatePassword(password);
                  if (_emailErrorText != null) {
                    ShowDialogWidget.showErrorDialog(
                      context: context,
                      title: 'Validation Error',
                      message: _emailErrorText!,
                    );
                  } else if (_passwordErrorText != null) {
                    ShowDialogWidget.showErrorDialog(
                      context: context,
                      title: 'Validation Error',
                      message: _passwordErrorText!,
                    );
                  } else {
                    final registerModel = LoginRequestModel(
                         email: email, password: password);
                    context
                        .read<LoginBloc>()
                        .add(LoginButtonPressed(registerModel));
                  }
                },
              );
            }
          },
        ),
      ],
    );
  }
}
