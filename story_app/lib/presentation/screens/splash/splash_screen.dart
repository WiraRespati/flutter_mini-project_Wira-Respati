import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/utils/constant/name_routes.dart';

import '../../bloc/user/auth/auth_bloc.dart';
import '../../bloc/user/auth/auth_event.dart';
import '../../bloc/user/auth/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      context.read<AuthBloc>().add(CheckLoginStatus());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              NameRoutes.navigationPageRoute,
              (route) => false,
            );
          } else if (state is AuthFailure) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              NameRoutes.loginPageRoute,
              (route) => false,
            );
          }
        },
        child: Center(
          child: Image.asset(
            "assets/logo-story-app.png",
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}
