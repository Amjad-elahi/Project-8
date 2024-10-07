import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:onze_cofe_project/components/custom_elevated_button/custom_elevated_button.dart';
import 'package:onze_cofe_project/components/custom_text/custom_text.dart';
import 'package:onze_cofe_project/components/app_bar/custom_app_bar.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';

import 'package:onze_cofe_project/screens/Home_screen/home_screen.dart';
import 'package:onze_cofe_project/screens/track_order_screen/bloc/track_order_bloc.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key, this.orderId});
  final int? orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TrackOrderBloc()..add(GetTrackOrderStatusEvent(orderID: orderId)),
      child: CustomBackgroundContainer(
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomAppBar(text: "Track Order"),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<TrackOrderBloc, TrackOrderState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(
                        child: Lottie.asset(
                            "assets/json/Animation - 1728142372274.json"));
                  } else if (state is SuccessState) {
                    final index = state.index;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                            text: "#100$orderId",
                            color: const Color(0xffF4F4F4),
                            size: 14),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                        text:
                                            "Your order has been confirmed! Thank you for choosing us. We’ll start preparing it right away.",
                                        color: Color(0xffF4F4F4),
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Center(
                                        child: Image.asset(
                                          "assets/images/order_confirm.png",
                                          width: 200,
                                        ),
                                      ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                        text:
                                            "Your order is ready for pickup! Come by anytime to collect it. We can’t wait to see you!",
                                        color: Color(0xffF4F4F4),
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Image.asset(
                                          "assets/images/ready_to_pick_up.png"),
                                      CustomElevatedButton(
                                        backgroundColor:
                                            const Color(0xffA8483D),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen()));
                                        },
                                        child: Center(
                                          child: const CustomText(
                                            text: "Done",
                                            color: Color(0xffF4F4F4),
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (state is ErrorState) {
                    return Center(child: Text(state.msg));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
