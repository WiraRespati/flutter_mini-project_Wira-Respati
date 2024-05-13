import 'package:flutter/material.dart';
import 'package:story_app/utils/constant/color_constant.dart';

class ButtonProfile extends StatefulWidget {
  final Widget widget;
  final double width;
  final double height;
  final Function()? onTap;
  const ButtonProfile(
      {super.key,
      this.onTap,
      required this.width,
      required this.height,
      required this.widget});

  @override
  State<ButtonProfile> createState() => _ButtonProfileState();
}

class _ButtonProfileState extends State<ButtonProfile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            color: ColorConstant.onPrimaryColor),
        child: widget.widget,
      ),
    );
  }
}
