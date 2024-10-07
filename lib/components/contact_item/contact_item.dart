import 'package:flutter/material.dart';

Widget buildContactItem({
  required IconData icon,
  required String label,
  required String info,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding:
          const EdgeInsets.only(left: 18.0, right: 25.0, bottom: 6, top: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromRGBO(158, 181, 190, 0.65),
            borderRadius: BorderRadius.circular(35)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: const Color.fromRGBO(61, 107, 125, 1),
                size: 40,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                        color: Color.fromRGBO(192, 196, 171, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    info,
                    style: const TextStyle(
                        color: Color.fromRGBO(192, 196, 171, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}