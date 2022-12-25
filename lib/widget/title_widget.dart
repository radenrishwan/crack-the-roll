import 'package:crack_the_roll/common/constant.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final List<Widget>? trailing;
  final String title;
  final IconData? icon;
  final Color? iconColor;
  const TitleWidget({super.key, required this.title, this.icon, this.iconColor, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: kTitleFontFamily.copyWith(
            color: kPrimaryColor,
            letterSpacing: 0.6,
            fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
          ),
        ),
        SizedBox(width: kDefaultPadding.right),
        icon != null ? Icon(icon, color: iconColor ?? Theme.of(context).primaryColor) : Container(),
        const Spacer(),
        ...trailing ?? [],
      ],
    );
  }
}
