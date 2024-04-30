import 'package:flutter/material.dart';
import 'package:story_app/presentation/screens/user/login/widget/footer_login_widget.dart';
import 'package:story_app/presentation/screens/user/login/widget/form_login_widget.dart';
import 'package:story_app/presentation/screens/user/login/widget/header_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final webScreenSize = 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              const HeaderLoginWidget(),
              const SizedBox(height: 64),
              const FormLoginWidget(),
              const SizedBox(height: 24),
              Flexible(flex: 2, child: Container()),
              const FooterLoginWidget()
            ],
          ),
        ),
      ),
    );
  }
}
