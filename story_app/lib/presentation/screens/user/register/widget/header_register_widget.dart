import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/constant/color_constant.dart';

class HeaderRegisterWidget extends StatelessWidget {
  const HeaderRegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/ic_instagram.svg',
      // ignore: deprecated_member_use
      color: ColorConstant.primaryColor,
      height: 64,
    );
  }
}
