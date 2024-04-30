import 'package:flutter/material.dart';

import '../../../../../utils/constant/name_routes.dart';


class FooterRegisterWidget extends StatelessWidget {
  const FooterRegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: const Text("Already have an account?"),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, NameRoutes.loginPageRoute);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: const Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
