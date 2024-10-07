import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';
import 'package:onze_cofe_project/components/custom_text/custom_text.dart';
import 'package:onze_cofe_project/components/text_form_field/custom_text_form_field.dart';
import 'package:onze_cofe_project/screens/auth/create_account_screen.dart';
import 'package:onze_cofe_project/screens/auth/cubit/auth_cubit.dart';
import 'package:onze_cofe_project/screens/auth/verify_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
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
              Navigator.pop(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VerifyScreen(email: cubit.logInController.text)));
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
                        const Align(
                            alignment: Alignment.centerLeft,
                            child:  CustomText(
                              text: "Login",
                              color: Color(0xffD7D2CB),
                              size: 24,
                              weight: FontWeight.w700,
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                              text: "Email",
                              color: const Color(0xffFFFFFF).withOpacity(0.72),
                              size: 16),
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        CustomTextFormField(
                          hintText: "Login",
                          controller: cubit.logInController,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomText(
                                text: "Don’t have an account?",
                                color: Color(0x71FFFFFF),
                                size: 14),
                            const SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateAccountScreen()));
                              },
                              child: const CustomText(
                                  text: "Sign up",
                                  color: Color(0xffA8483D),
                                  size: 14),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 42,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffA8483D),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(21.5))),
                              onPressed: () {
                                cubit.signIn();
                              },
                              child: const Center(
                                child: CustomText(
                                    text: "Sign in",
                                    color: Color(0xffF4F4F4),
                                    size: 12),
                              )),
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
