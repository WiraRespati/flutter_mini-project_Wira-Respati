import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constant/color_constant.dart';

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: ColorConstant.primaryColor,
                height: 64,
              ),
      ],
    );
  }
}