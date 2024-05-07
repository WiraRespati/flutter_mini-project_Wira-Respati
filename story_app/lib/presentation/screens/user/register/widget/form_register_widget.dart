import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/data/models/user/register_request_model.dart';
import 'package:story_app/presentation/bloc/user/register/register_event.dart';

import '../../../../../utils/constant/name_routes.dart';
import '../../../../../utils/constant/validation.dart';
import '../../../../bloc/user/register/register_bloc.dart';
import '../../../../bloc/user/register/register_state.dart';
import '../../../../widgets/button_global_widget.dart';
import '../../../../widgets/show_dialog_widget.dart';
import '../../../../widgets/text_field_input.dart';

class FormRegisterWidget extends StatefulWidget {
  const FormRegisterWidget({super.key});

  @override
  State<FormRegisterWidget> createState() => _FormRegisterWidgetState();
}

class _FormRegisterWidgetState extends State<FormRegisterWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String? _nameErrorText;
  String? _emailErrorText;
  String? _passwordErrorText;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldInput(
          textEditingController: _nameController,
          textInputType: TextInputType.text,
          hintText: "Enter Your name",
          errorText: _nameErrorText,
          onChange: (value) {
            setState(() {
              _nameErrorText = Validation.validateNotEmpty(value,"Name");
            });
          },
          isPass: false,
          focusNode: _nameFocusNode,
        ),
        const SizedBox(height: 24),
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
        const SizedBox(height: 24),
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
        const SizedBox(height: 24),
        BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              Navigator.pushNamed(context, NameRoutes.initRoute);
            } else if (state is RegisterFailure) {
              ShowDialogWidget.showErrorDialog(
                context: context,
                title: 'Register Failed',
                message: state.error,
              );
            }
          },
          builder: (context, state) {
            if (state is RegisterLoading) {
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
                title: const Text('Register'),
                onTap: () {
                  final name = _nameController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  _nameErrorText = Validation.validateNotEmpty(name,"Name");
                  _emailErrorText = Validation.validateEmail(email);
                  _passwordErrorText = Validation.validatePassword(password);
                  if (_nameErrorText != null) {
                    ShowDialogWidget.showErrorDialog(
                      context: context,
                      title: 'Validation Error',
                      message: _nameErrorText!,
                    );
                  } else if (_emailErrorText != null) {
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
                    final registerModel = RegisterRequestModel(
                        name: name, email: email, password: password);
                    context
                        .read<RegisterBloc>()
                        .add(RegisterButtonPressed(registerModel));
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
