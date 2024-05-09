import 'package:flutter/material.dart';

import '../../../../utils/constant/color_constant.dart';

class StoryHighlightWidget extends StatelessWidget {
  final String name;
  final Function()? onTap;

  const StoryHighlightWidget({super.key, required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            
            children: [
              CircleAvatar(
                backgroundColor: ColorConstant.onPrimaryColor,
                radius: 44,
                child: Text(name[0].toUpperCase()),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(name),
              ),
            ],
          )),
    );
  }
}
