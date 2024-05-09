import 'package:flutter/material.dart';


class HeaderRegisterWidget extends StatelessWidget {
  const HeaderRegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            "assets/logo-story-app.png",
            width: 200,
            height: 200,
          ),
        ],
      ),
    );
  }
}
