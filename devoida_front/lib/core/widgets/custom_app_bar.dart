import 'package:devoida_front/core/utils/theming/styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.leading,
    required this.title,
    required this.actions,
  });
  final Widget leading;
  final String title;
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        children: [
          leading,
          SizedBox(width: 10),
          Text(title, style: Styles.titleStyle),
          Row(children: actions),
        ],
      ),
    );
  }
}
