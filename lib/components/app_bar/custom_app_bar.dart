import 'package:flutter/material.dart';

import '../custom_text/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: const Color(0xffF4F4F4),
      title: CustomText(
        text: text,
        color: const Color(0xffF4F4F4),
        size: 20,
        weight: FontWeight.w500,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
