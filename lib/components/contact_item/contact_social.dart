import 'package:flutter/material.dart';

Widget buildSocialMediaItem({
    required String iconPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 6, top: 6.0),
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(158, 181, 190, 0.65),
              borderRadius: BorderRadius.circular(40)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  iconPath,
                  height: 40,
                ),
               const SizedBox(width: 20),
                Text(
                  label,
                  style: const TextStyle(
                          color: Color.fromRGBO(192, 196, 171, 1),

                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }