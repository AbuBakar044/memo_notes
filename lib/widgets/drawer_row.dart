import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class DrawerRow extends StatelessWidget {
  final IconData? icon;
  final String? text;
  const DrawerRow({super.key, this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: kWhiteColor,
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          text!,
          style: const TextStyle(
            color: kWhiteColor,
          ),
        ),
      ],
    );
  }
}
