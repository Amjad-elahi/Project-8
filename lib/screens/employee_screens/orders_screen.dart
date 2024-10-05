import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:onze_cofe_project/components/custom_text/custom_text.dart';
import 'package:onze_cofe_project/components/lists/custom_orders_list_tile.dart';
import 'package:onze_cofe_project/screens/employee_screens/bloc/order_state_bloc.dart';
import '../../components/containers/custom_background_container.dart';
import 'order_state_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderStateBloc()..add(GetOrdersEvent()),
      child: Builder(builder: (context) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color(0xffF4F4F4),
              foregroundColor: const Color(0xff3D6B7D),
              title: const CustomText(
                text: "Orders",
                color: Color(0xff3D6B7D),
                size: 20,
                weight: FontWeight.w600,
              ),
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu_rounded),
              ),
              bottom: TabBar(
                indicatorColor: const Color(0xff87B1C5),
                labelColor: const Color(0xff3D6B7D),
                unselectedLabelColor: const Color(0xff4A7585).withOpacity(0.44),
                tabs: const [
                  Text(
                    "Current orders",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "Completed orders",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            body: CustomBackgroundContainer(
              child: BlocBuilder<OrderStateBloc, OrderStateState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(
                      child: Lottie.asset(
                        "assets/json/Animation - 1728142372274.json",
                      ),
                    );
                  } else if (state is ErrorState) {
                    print(state.msg);
                    return Center(child: Text('Error: ${state.msg}'));
                  } else if (state is OrdersState) {
                    final orders = state.orders;
                    final status = state.status;

                    if (orders.isEmpty) {
                      return const Center(child: Text('No Orders Found'));
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TabBarView(
                        children: [
                          ListView(
                            children: orders
                                .where((order) =>
                                    status[orders.indexOf(order)] != "Done")
                                .map((order) {
                              final orderId = order['order_id'];
                              final userName = order['users']['name'];
                              final userID = order['user_id'];
                              print(userID);
                              final orderStatus = status[orders.indexOf(order)];
                              IconData icon;

                              switch (orderStatus) {
                                case "Received":
                                  icon = Icons.circle;
                                  break;
                                case "In progress":
                                  icon = Icons.watch_later_outlined;
                                  break;
                                default:
                                  icon = Icons.check;
                              }

                              return Column(
                                children: [
                                  CustomOrdersListTile(
                                    text: "Order #100$orderId",
                                    icon: icon,
                                    color: const Color(0xffD7D1CA),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OrderStateScreen(
                                            orderID: orderId,
                                            userName: userName,
                                            userID: userID,
                                          ),
                                        ),
                                      )
                                          .then((_) {
                                        context
                                            .read<OrderStateBloc>()
                                            .add(GetOrdersEvent());
                                      });
                                    },
                                  ),
                                  const Divider(color: Color(0xffD7D1CA)),
                                ],
                              );
                            }).toList(),
                          ),
                          ListView(
                            children: orders
                                .where((order) =>
                                    status[orders.indexOf(order)] == "Done")
                                .map((order) {
                              final orderId = order['order_id'];
                              final orderStatus = status[orders.indexOf(order)];
                              IconData icon;

                              switch (orderStatus) {
                                case "Received":
                                  icon = Icons.circle;
                                  break;
                                case "In progress":
                                  icon = Icons.watch_later_outlined;
                                  break;
                                default:
                                  icon = Icons.check;
                              }

                              return Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(
                                      icon,
                                      color: const Color(0xffD7D1CA),
                                    ),
                                    title: CustomText(
                                      text: "Order #100$orderId",
                                      color: const Color(0xffD7D1CA),
                                      size: 20,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                  const Divider(color: Color(0xffD7D1CA)),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
