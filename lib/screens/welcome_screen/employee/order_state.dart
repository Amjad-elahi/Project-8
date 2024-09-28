import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:onze_cofe_project/components/app_bar/custom_app_bar.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';
import 'package:onze_cofe_project/components/containers/custom_order_container.dart';
import 'package:onze_cofe_project/components/custom_elevated_button/custom_elevated_button.dart';
import 'package:onze_cofe_project/components/custom_text/custom_text.dart';
import 'package:onze_cofe_project/screens/welcome_screen/employee/bloc/order_state_bloc.dart';

class OrderState extends StatelessWidget {
  const OrderState({super.key});

  String formatTime(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderStateBloc(),
      child: Builder(builder: (context) {
        return CustomBackgroundContainer(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: const CustomAppBar(text: "Order\n#1234"),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: BlocBuilder<OrderStateBloc, OrderStateState>(
                  builder: (context, state) {
                    if (state is OrderStateInitial) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                const CustomText(
                                  text: "Name: aaaaa",
                                  color: Color(0xffF4F4F4),
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                CustomOrderContainer(
                                    image: CircleAvatar(
                                      radius: 35,
                                      child: Image.asset(
                                        "assets/png/Cappuccino1.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    title: "Cappuccino",
                                    subtitle: "12 SAR"),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomOrderContainer(
                                    image: Image.asset(
                                        "assets/png/Cappuccino1.png"),
                                    title: "Cappuccino",
                                    subtitle: "12 SAR"),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 287,
                              child: CustomElevatedButton(
                                backgroundColor: const Color(0xffA8483D),
                                onPressed: () {
                                  context
                                      .read<OrderStateBloc>()
                                      .add(StartTimerEvent());
                                },
                                child: const CustomText(
                                    text: "Start",
                                    color: Color(0xffF4F4F4),
                                    size: 16),
                              ),
                            ),
                          )
                        ],
                      );
                    } else if (state is RunningState) {
                      return Column(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text: "Name: aaaaa",
                                  color: Color(0xffF4F4F4),
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      Lottie.asset(
                                          "assets/json/Animation - 1727514346086.json",
                                          width: 300,
                                          height: 300),
                                      CustomText(
                                          text: formatTime(state.seconds),
                                          color: const Color(0xffF4F4F4),
                                          size: 30),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 287,
                              child: CustomElevatedButton(
                                backgroundColor: const Color(0xffA8483D),
                                onPressed: () {
                                  context
                                      .read<OrderStateBloc>()
                                      .add(StopTimerEvent());
                                },
                                child: const CustomText(
                                    text: "Done",
                                    color: Color(0xffF4F4F4),
                                    size: 16),
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text: "Name: aaaaa",
                                  color: Color(0xffF4F4F4),
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      Lottie.asset(
                                          "assets/json/Animation - 1727514346086.json",
                                          width: 300,
                                          height: 300),
                                      const CustomText(
                                          text: "Time's up!",
                                          color: Color(0xffFBFBFB),
                                          size: 20),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 287,
                              child: CustomElevatedButton(
                                backgroundColor: const Color(0xffA8483D),
                                onPressed: () {},
                                child: const CustomText(
                                    text: "Done",
                                    color: Color(0xffF4F4F4),
                                    size: 16),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  },
                ),
              )),
        );
      }),
    );
  }
}
