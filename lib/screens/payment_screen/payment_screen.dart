import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:onze_cofe_project/screens/track_order_screen/track_order_screen.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen(
      {super.key, required this.totalPrice, required this.totalTime});
  final double totalPrice;
  final int totalTime;

  paymentConfig() {
    return PaymentConfig(
      publishableApiKey: 'pk_test_PB1baNgjCqvDmTbqdZQMCKXTWQejHLM7NUxwwRLV',
      amount: (totalPrice * 100).toInt(), // SAR 257.58
      description: 'order #1324',
      metadata: {'size': '250g'},
      creditCard: CreditCardConfig(saveCard: true, manual: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        child: CreditCard(
          config: paymentConfig(),
          onPaymentResult: (PaymentResponse data) async {
            print("---------------- ${data.id}");
            print("---------------- ${data.amount}");
            print("---------------- ${data.status.name}");
            if (data.status.name == "paid") {
              final response = await getIt
                  .get<DataLayer>()
                  .supabase
                  .from("orders")
                  .insert({
                    "order_time": totalTime,
                    "user_id":
                        getIt.get<DataLayer>().supabase.auth.currentUser!.id,
                  })
                  .select()
                  .single();

              print(response);
              for (var element in getIt.get<DataLayer>().viewCartItems()) {
                await getIt
                    .get<DataLayer>()
                    .supabase
                    .from("order_items")
                    .insert({
                  "product_id": element['product_id'],
                  "price": element["price"],
                  "quantity": element["quantity"],
                  "order_id": response["order_id"]
                });
              }
              await getIt.get<DataLayer>().supabase.from("bill").insert({
                "user_id": getIt.get<DataLayer>().supabase.auth.currentUser!.id,
                "order_id": response['order_id'],
                "price": totalPrice,
                "payment_method":
                    "mada" // our only current payment_method "mada"
              });
              getIt.get<DataLayer>().itemsList = [];
              getIt.get<DataLayer>().box.remove("ProductsList");
              getIt.get<DataLayer>().orderID = response['order_id'];
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TrackOrderScreen(
                            orderId: response['order_id'],
                          )));
            }
            print("---------------- ${data.createdAt}");
          },
        ),
      ),
    );
  }
}
