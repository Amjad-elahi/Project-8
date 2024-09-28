import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:onze_cofe_project/components/custom_text/custom_text.dart';

import '../../components/app_bar/custom_app_bar.dart';
import '../../components/containers/custom_background_container.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return CustomBackgroundContainer(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const CustomAppBar(text: "Track Order"),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomText(
                    text: "#234567", color: Color(0xffF4F4F4), size: 14),
                Expanded(
                  child: Stepper(
                    controlsBuilder: (context, details) {
                      return const SizedBox.shrink();
                    },
                    elevation: 0,
                    type: StepperType.vertical,
                    currentStep: index,
                    steps: <Step>[
                      Step(
                        title: const CustomText(
                          text: "Order confirmed",
                          color: Color(0xffF4F4F4),
                          size: 16,
                          weight: FontWeight.w600,
                        ),
                        stepStyle: StepStyle(
                            color: index == 0
                                ? const Color.fromARGB(255, 45, 80, 94)
                                : const Color(0xffF4F4F4),
                            indexStyle: TextStyle(
                                color: index == 0
                                    ? const Color(0xffF4F4F4)
                                    : const Color(0xff3D6B7D))),
                        content: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text:
                                    "Your order has been confirmed! Thank you for choosing us. We’ll start preparing it right away.",
                                color: Color(0xffF4F4F4),
                                size: 16,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Lottie.asset(
                                  "assets/json/Animation - 1727532447033.json"),
                            ],
                          ),
                        ),
                      ),
                      Step(
                        title: const CustomText(
                          text: "Order in progress",
                          color: Color(0xffF4F4F4),
                          size: 16,
                          weight: FontWeight.w600,
                        ),
                        stepStyle: StepStyle(
                            color: index == 1
                                ? const Color.fromARGB(255, 45, 80, 94)
                                : const Color(0xffF4F4F4),
                            indexStyle: TextStyle(
                                color: index == 1
                                    ? const Color(0xffF4F4F4)
                                    : const Color(0xff3D6B7D))),
                        content: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text:
                                    "We’ve begun preparing your coffee! it’ll be ready soon.",
                                color: Color(0xffF4F4F4),
                                size: 16,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Lottie.asset(
                                "assets/json/Animation - 1727514346086.json",
                              ),
                            ],
                          ),
                        ),
                      ),
                      Step(
                        title: const CustomText(
                          text: "Ready to pick up",
                          color: Color(0xffF4F4F4),
                          size: 16,
                          weight: FontWeight.w600,
                        ),
                        stepStyle: StepStyle(
                            color: index == 2
                                ? const Color.fromARGB(255, 45, 80, 94)
                                : const Color(0xffF4F4F4),
                            indexStyle: TextStyle(
                                color: index == 2
                                    ? const Color(0xffF4F4F4)
                                    : const Color(0xff3D6B7D))),
                        content: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text:
                                    "Your order is ready for pickup! Come by anytime to collect it. We can’t wait to see you!",
                                color: Color(0xffF4F4F4),
                                size: 16,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Lottie.asset(
                                  'assets/json/Animation - 1727532897759.json'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
