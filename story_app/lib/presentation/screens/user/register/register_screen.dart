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
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              SizedBox(height: 24), // Tambahkan ruang atas
              HeaderRegisterWidget(),
              SizedBox(height: 8),
              FormRegisterWidget(),
              SizedBox(height: 24),
              FooterRegisterWidget(),
              SizedBox(height: 24), // Tambahkan ruang bawah
            ],
          ),
        ),
      ),
    );
  }
}
