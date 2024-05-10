import 'package:flutter/material.dart';

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({super.key});

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
          const Text(
            'Login to share your story...',
            style: TextStyle(fontFamily: 'BriemHand'),
          )
        ],
      ),
    );
  }
}
