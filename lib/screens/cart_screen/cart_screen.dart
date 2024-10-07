import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';
import 'package:onze_cofe_project/components/item/cartItem.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:onze_cofe_project/screens/payment_screen/payment_screen.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';

import 'cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initial load of cart items from DataLayer
    List<Map<String, dynamic>> initialCartItems =
        getIt.get<DataLayer>().viewCartItems();

    return BlocProvider(
      create: (context) =>
          CartCubit(initialCartItems), // Pass initial cart items to the cubit
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            title: const Text(
              "Cart",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: const Color(0xff3D6B7D),
          ),
          body: CustomBackgroundContainer(
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state is CartLoading) {
                        return Center(
                            child: Lottie.asset(
                                "assets/json/Animation - 1728142372274.json"));
                      } else if (state is CartSuccess) {
                        if (state.cartItems.isEmpty) {
                          return const Center(
                            child: Text(
                              'Your cart is empty.',
                              style: TextStyle(color: Color(0xfff4f4f4)),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: state.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = state.cartItems[index];
                            return CartItem(
                              name: item['name'],
                              price: double.parse(item['price'].toString()),
                              imgUrl: item['image_url'],
                              quantity: int.parse(item['quantity'].toString()),
                              productId: item['product_id'],
                            );
                          },
                        );
                      } else if (state is CartError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                const Center(
                  child: Divider(
                    color: Colors.white70,
                    thickness: 2.5,
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is CartSuccess) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              "${state.totalPrice.toStringAsFixed(2)} SAR",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container(); // Return empty container if not in CartSuccess state
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // showModalBottomSheet(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return OrderNotificationScreen();
                      //   },
                      // );
                      final finalPrice = context.read<CartCubit>().priceTotal;
                      int totaltime = 0;
                      for (var element
                          in getIt.get<DataLayer>().viewCartItems()) {
                        totaltime = totaltime +
                            int.parse(element['waiting_time'].toString());
                      }
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return PaymentScreen(
                            totalTime: totaltime,
                            totalPrice: finalPrice,
                          );
                        },
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => PaymentScreen(
                      //               totalTime: totaltime,
                      //               totalPrice: finalPrice,
                      //             )));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA8483D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                    ),
                    child: const Center(
                      child: Text(
                        "Place Order",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
