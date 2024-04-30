import 'package:flutter/material.dart';

import '../../../../utils/constant/color_constant.dart';

class StoryHighlightWidget extends StatelessWidget {
  final String name;

  const StoryHighlightWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: ColorConstant.webBackgroundColor,
            radius: 36,
            child: Text(name[0]),
          ),
        )
      ],
    );
  }
}
