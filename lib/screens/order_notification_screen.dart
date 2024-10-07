import 'package:flutter/material.dart';
import 'package:onze_cofe_project/components/custom_elevated_button/custom_elevated_button.dart';

class OrderNotificationScreen extends StatelessWidget {
  const OrderNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 40,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 90),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Almost There!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3D6B7D),
                  ),
                ),
                Text(
                  'There are a couple of orders ahead \n of you, so you\'ll need to wait for about 3 minutes. Would you like to proceed with your order?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF3D6B7D),
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomElevatedButton(
              onPressed: () {}, //myaser page
              backgroundColor: const Color(0xFF3D6B7D),
              child: const Text(
                'Proceed To Payment',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
