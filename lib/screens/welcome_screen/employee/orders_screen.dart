import 'package:flutter/material.dart';
import 'package:onze_cofe_project/components/custom_text/custom_text.dart';
import 'package:onze_cofe_project/components/lists/custom_orders_list_tile.dart';

import '../../../components/containers/custom_background_container.dart';
import 'order_state.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xffF4F4F4),
            foregroundColor: const Color(0xff3D6B7D),
            title: const CustomText(
              text: "Orders",
              color: Color(0xff3D6B7D),
              size: 20,
              weight: FontWeight.w500,
            ),
            leading: IconButton(
                onPressed: () {}, icon: const Icon(Icons.menu_rounded)),
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
                  )
                ])),
        body: CustomBackgroundContainer(
          child: TabBarView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  CustomOrdersListTile(
                    text: "Order #23456",
                    icon: Icons.watch_later_outlined,
                    color: const Color(0xffD7D1CA),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OrderState()));
                    },
                  ),
                  const Divider(
                    color: Color(0xffD7D1CA),
                  ),
                  CustomOrdersListTile(
                    text: "Order #2345",
                    icon: Icons.circle_rounded,
                    color: const Color(0xffA8483D),
                    onPressed: () {},
                  ),
                  const Divider(
                    color: Color(0xffD7D1CA),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  CustomOrdersListTile(
                    text: "Order #23456",
                    icon: Icons.watch_later_outlined,
                    color: const Color(0xffD7D1CA),
                    onPressed: () {},
                  ),
                  const Divider(
                    color: Color(0xffD7D1CA),
                  ),
                  CustomOrdersListTile(
                    text: "Order #2345",
                    icon: Icons.circle_rounded,
                    color: const Color(0xffA8483D),
                    onPressed: () {},
                  ),
                  const Divider(
                    color: Color(0xffD7D1CA),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
