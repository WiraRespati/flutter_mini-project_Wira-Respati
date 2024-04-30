import 'package:flutter/material.dart';
import 'package:story_app/presentation/screens/user/register/widget/footer_register_widget.dart';
import 'package:story_app/presentation/screens/user/register/widget/form_register_widget.dart';
import 'package:story_app/presentation/screens/user/register/widget/header_register_widget.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: MediaQuery.of(context).size.width > 600
          ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3)
          : const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(flex: 2, child: Container()),
          const HeaderRegisterWidget(),
          const SizedBox(height: 64),
          const FormRegisterWidget(),
          const SizedBox(height: 24),
          Flexible(flex: 2, child: Container()),
          const FooterRegisterWidget()
        ],
      ),
    )));
  }
}
