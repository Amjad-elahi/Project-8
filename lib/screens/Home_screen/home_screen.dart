import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3D6B7D), // --------- for now -------
      appBar: AppBar(
        //------------------ or put custom appbar ---------------

        iconTheme: const IconThemeData(color: Color(0xffF4F4F4)),
        actions: [
          IconButton(
              onPressed: () {
                //navigate to cart
              },
              icon: Badge.count(
                  backgroundColor: const Color(0xffA8483D),
                  count: 1, //changes accorfing to order items quantity
                  child: const Icon(
                      Icons.cabin))), //change it after adding assets folder
          const SizedBox(
            width: 20,
          ),
        ],

        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      ),
      drawer: const Drawer(
        child: Padding(padding: EdgeInsets.only(left: 30)),
      ), // ----------- custom drawer --------------

      body: SafeArea(
          child: Center(
        child: ListView(
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(79, 255, 255, 255),
                        hintText: 'What would you like to order?',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(213, 255, 255, 255),
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon:
                            const Icon(Icons.search, color: Color(0xffF4F4F4)),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Open filter
                    },
                    icon: const Icon(Icons
                        .filter_alt), //change it after adding assets folder
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Swiper(
              layout: SwiperLayout.CUSTOM,
              customLayoutOption:
                  CustomLayoutOption(startIndex: -1, stateCount: 3)
                    ..addRotate([-90.0 / 180, 0.0, 90.0 / 180])
                    ..addTranslate([
                      Offset(-490.0, -30.0),
                      Offset(0.0, 0.0),
                      Offset(490.0, -30.0)
                    ]),
              itemWidth: double.infinity,
              itemHeight: 600,
              itemBuilder: (context, index) {
                return CoffeeCard(
                  name: 'Cappuccino',
                  price: 12,
                  imgURL:
                      'https://i.postimg.cc/fRgnzCYm/image-from-rawpixel-id-15496747-png-2-1.png',
                );
              },
              itemCount: 10,
            )
          ],
        ),
      )),
    );
  }
}

class CoffeeCard extends StatelessWidget {
  final String name;
  final double price;
  final String imgURL;

  const CoffeeCard({
    super.key,
    required this.name,
    required this.price,
    required this.imgURL,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star, //change it after adding assets folder
                  color: Color.fromARGB(255, 108, 182, 211),
                ),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 32,
                      color: Color(0xffF4F4F4),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '${price.toString()} SAR',
              style: const TextStyle(fontSize: 16, color: Color(0xffF4F4F4)),
            ),
            const SizedBox(height: 10),
            Image.network(
              imgURL,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 400, 0, 0),
          child: Positioned(
            child: ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(
                      Color(0xff3D6B7D)) //whats the new way for this?
                  ),
              onPressed: () {
                //add to cart
              },
              child: const Text('+ Add To Cart'),
            ),
          ),
        ),
      ],
    );
  }
}
