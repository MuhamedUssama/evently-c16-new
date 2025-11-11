import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/ColorsManager.dart';

class CustomSwitch extends StatelessWidget {
  final String selected;
  final List<String> values;
  final Function(String) onChanged;
  final String icon1;
  final String icon2;
  final bool isColored;
  const CustomSwitch({
    super.key,
    required this.selected,
    required this.icon2,
    required this.icon1,
    required this.onChanged,
    required this.values,
    this.isColored = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: AnimatedToggleSwitch<String>.rolling(
        current: selected,
        values: values,
        onChanged: onChanged,
        indicatorSize: const Size(40, 40),
        spacing: 16,
        iconOpacity: 1,
        style: ToggleStyle(
          backgroundColor: Colors.transparent,
          indicatorColor: ColorsManager.primaryColor,
          borderColor: ColorsManager.primaryColor,
          indicatorBorderRadius: BorderRadius.circular(20),
        ),
        iconList: [
          SvgPicture.asset(
            icon1,
            height: 30,
            width: 30,
            colorFilter: isColored
                ? ColorFilter.mode(
                    selected == "light"
                        ? Colors.white
                        : ColorsManager.primaryColor,
                    BlendMode.srcIn,
                  )
                : null,
          ),
          SvgPicture.asset(
            icon2,
            height: 30,
            width: 30,
            colorFilter: isColored
                ? ColorFilter.mode(
                    selected == "dark"
                        ? Colors.white
                        : ColorsManager.primaryColor,
                    BlendMode.srcIn,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
