import 'package:flutter/material.dart';

import '../../utils/constant/color_constant.dart';

class ButtonGlobalWidget extends StatelessWidget {
  final Widget title;
  final Function()? onTap;
  const ButtonGlobalWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: ShapeDecoration(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            color: ColorConstant.blueColor),
        child: title,
      ),
    );
  }
}
