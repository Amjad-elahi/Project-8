import 'package:flutter/material.dart';

import '../custom_text/custom_text.dart';

class CustomOrdersListTile extends StatelessWidget {
  const CustomOrdersListTile(
      {super.key, required this.text, this.onPressed, this.icon, this.color});
  final String text;
  final Function()? onPressed;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: color,
      ),
      title: CustomText(
        text: text,
        color: const Color(0xffD7D1CA),
        size: 20,
        weight: FontWeight.w600,
      ),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.arrow_forward_ios_outlined,
            color: Color(0xffD7D1CA),
          )),
    );
  }
}
