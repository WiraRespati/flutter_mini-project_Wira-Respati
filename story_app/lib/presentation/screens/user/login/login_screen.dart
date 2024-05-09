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
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body:  SingleChildScrollView(
        child:  Padding(
          padding: EdgeInsets.all(32.0),
          child:  Column(
            children: [
              SizedBox(height: 24), // Tambahkan ruang atas
              HeaderLoginWidget(),
              SizedBox(height: 8),
              FormLoginWidget(),
              SizedBox(height: 24),
              FooterLoginWidget(),
              SizedBox(height: 24), // Tambahkan ruang bawah
            ],
          ),
        ),
      ),
    );
  }
}
