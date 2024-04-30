import 'package:flutter/material.dart';

import '../../../../../utils/constant/name_routes.dart';

class FooterLoginWidget extends StatelessWidget {
  const FooterLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: const Text("Don't have an account?"),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, NameRoutes.registerPageRoute);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: const Text(
              "Register",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
