import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key, required this.hintText, this.controller, this.validator});
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xff3D6B7D), Color(0xffD7D1CA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.2, 1.0]),
          borderRadius: BorderRadius.circular(21.5)),
      child: Container(
        height: 43,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21.5),
            color: const Color(0xff85a2ad)),
        child: TextFormField(
          style: TextStyle(color: Color(0xffF4F4F4)),
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 15, bottom: 10),
              hintStyle:
                  const TextStyle(fontSize: 12, color: Color(0x72FFFFFF)),
              hintText: hintText),
        ),
      ),
    );
  }
}
