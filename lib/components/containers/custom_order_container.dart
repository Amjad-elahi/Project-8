import 'package:flutter/material.dart';

import '../custom_text/custom_text.dart';

class CustomOrderContainer extends StatelessWidget {
  const CustomOrderContainer(
      {super.key, required this.title, required this.subtitle, this.image});
  final String title;
  final String subtitle;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 120,
      decoration: BoxDecoration(
          color: const Color(0xffFFFFFF).withOpacity(0.5),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: ListTile(
          leading: CircleAvatar(radius: 35, child: image),
          title: CustomText(
            text: title,
            color: Color(0xff3D6B7D),
            size: 20,
            weight: FontWeight.w600,
          ),
          subtitle:
              CustomText(text: subtitle, color: Color(0xfff3D6B7D), size: 16),
        ),
      ),
    );
  }
}
