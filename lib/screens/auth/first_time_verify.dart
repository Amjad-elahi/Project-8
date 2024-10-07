import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';
import 'package:onze_cofe_project/components/custom_text/custom_text.dart';
import 'package:onze_cofe_project/screens/Home_screen/home_screen.dart';
import 'package:onze_cofe_project/screens/auth/cubit/auth_cubit.dart';
import 'package:pinput/pinput.dart';

class FirstTimeVerify extends StatelessWidget {
  const FirstTimeVerify(
      {super.key, required this.email, required this.firstName});
  final String email;
  final String firstName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        return BlocListener<AuthCubit, AuthStatee>(
          listener: (context, state) {
            if (state is LoadingState) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Lottie.asset(
                            "assets/json/Animation - 1728142372274.json"),
                      ));
            }
            if (state is SuccessState) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            }
            if (state is ErrorState) {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.msg,
                    style: const TextStyle(color: Color(0xff467283)),
                  ),
                  backgroundColor: const Color(0xfff4f4f4),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: Scaffold(
            body: CustomBackgroundContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/g8.png"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                                text: "Verify $email",
                                color: const Color(0xffD7D2CB),
                                size: 24)),
                        const SizedBox(
                          height: 40,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                              text: "Email",
                              color: Color(0x72FFFFFF),
                              size: 12),
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Pinput(
                          onCompleted: (value) => context
                              .read<AuthCubit>()
                              .firstTimeVerifyOTP(
                                  email: email, name: firstName, otp: value),
                          length: 6,
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 42,
                          // child: ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //         backgroundColor: const Color(0xffA8483D),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius:
                          //                 BorderRadius.circular(21.5))),
                          //     onPressed: () {},
                          //     child: const Center(
                          //       child: const CustomText(
                          //           text: "Verify OTP",
                          //           color: Color(0xffF4F4F4),
                          //           size: 12),
                          //     )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
