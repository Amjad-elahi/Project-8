import 'package:flutter/material.dart';

import '../custom_text/custom_text.dart';

class CustomOrderContainer extends StatelessWidget {
  const CustomOrderContainer(
      {super.key,
      required this.title,
      required this.subtitle,
      this.image,
      required this.quantity});
  final String title;
  final String subtitle;
  final String quantity;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 350,
          height: 120,
          decoration: BoxDecoration(
              color: const Color(0xffFFFFFF).withOpacity(0.5),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: ListTile(
              leading: image,
              title: CustomText(
                text: title,
                color: const Color(0xff3D6B7D),
                size: 20,
                weight: FontWeight.w600,
              ),
              subtitle: CustomText(
                  text: subtitle, color: const Color(0xfff3d6b7d), size: 16),
              trailing: CustomText(
                  text: quantity, color: const Color(0xfff3d6b7d), size: 14),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
