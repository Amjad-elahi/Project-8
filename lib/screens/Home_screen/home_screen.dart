import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:onze_cofe_project/screens/Home_screen/bloc/home_bloc.dart';
import 'package:onze_cofe_project/screens/cart_screen/cart_screen.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';

import '../drawer_screen/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<HomeBloc>();

        //selected button style
        Widget filterButton(BuildContext context, String filter) {
          return TextButton(
            onPressed: () {
              {
                if (bloc.selectedFilter == filter) {
                  // do nothing
                  return;
                } else {
                  // Select the new filter
                  bloc.selectedFilter = filter;

                  if (filter == 'All') {
                    bloc.add(LoadScreenEvent());
                    Navigator.pop(context);
                  } else {
                    bloc.add(FilterSelectedEvent(selectedFilter: filter));
                    Navigator.pop(context);
                  }
                }
              }
            },
            child: Text(
              filter,
              style: TextStyle(
                fontSize: 20,
                color: bloc.selectedFilter == filter
                    ? const Color(0xff88B0C4)
                    : const Color(0xff467283),
              ),
            ),
          );
        }

        bloc.add(LoadScreenEvent());
        return BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                    backgroundColor: Colors.transparent,
                    content: Lottie.asset(
                        "assets/json/Animation - 1728142372274.json")),
              );
            } else if (state is SuccessState) {
              Navigator.pop(context);
            } else if (state is ErrorState) {
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
            backgroundColor: const Color(0xff3D6B7D),
            appBar: AppBar(
              //------------------ or put custom appbar ---------------

              iconTheme: const IconThemeData(color: Color(0xffF4F4F4)),
              actions: [
                IconButton(onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartScreen()));
                }, icon: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (getIt.get<DataLayer>().viewCartItems().length == 0) {
                      return SvgPicture.asset('assets/svg/cart.svg');
                    }
                    return Badge.count(
                        backgroundColor: const Color(0xffA8483D),
                        count: getIt
                            .get<DataLayer>()
                            .viewCartItems()
                            .length, //changes accorfing to cart items quantity
                        child: SvgPicture.asset('assets/svg/cart.svg'));
                  },
                )),
                const SizedBox(
                  width: 20,
                ),
              ],

              backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            ),
            drawer: CustomDrawer(
              name: getIt.get<DataLayer>().currentUserInfo!['name'],
            ),
            body: CustomBackgroundContainer(
              child: Center(
                child: Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                bloc.searchQuery = value;

                                bloc.add(SearchEvent());
                              },
                              style: const TextStyle(color: Color(0xfff4f4f4)),
                              cursorColor: const Color(0xfff4f4f4),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(79, 255, 255, 255),
                                hintText: 'What would you like to order?',
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(213, 255, 255, 255),
                                  fontSize: 12,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(Icons.search,
                                    color: Color(0xffF4F4F4)),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 5),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    width: double.infinity,
                                    height: 400,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50),
                                      ),
                                      color: Color.fromRGBO(244, 244, 244, 0.9),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        filterButton(context, 'All'),
                                        filterButton(context, 'Hot coffee'),
                                        filterButton(context, 'Cold coffee'),
                                        filterButton(context, 'Tea'),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: SvgPicture.asset('assets/svg/filter.svg'),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                      if (state is SuccessState || state is SearchItemState) {
                        return SizedBox(
                          height: 500,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Container(
                                  height: 400,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(200),
                                      topRight: Radius.circular(200),
                                    ),
                                    color: Color(0xffD8D3CC),
                                  ),
                                ),
                              ),
                              Swiper(
                                duration: 1000,
                                autoplay: true,
                                autoplayDelay: 7000,
                                layout: SwiperLayout.CUSTOM,
                                customLayoutOption: CustomLayoutOption(
                                    startIndex: 0, stateCount: 3)
                                  ..addRotate([-90.0 / 180, 0.0, 90.0 / 180])
                                  ..addTranslate([
                                    const Offset(-500.0, -30.0),
                                    const Offset(0.0, 0.0),
                                    const Offset(500.0, -30.0),
                                  ]),
                                itemWidth: double.infinity,
                                itemHeight: 500,
                                itemBuilder: (context, index) {
                                  currentIndex = index;
                                  final item = bloc.filteredQuery[index];
                                  return CoffeeCard(
                                    name: item['name'],
                                    price:
                                        double.parse(item['price'].toString()),
                                    imgURL: item['image_url'],
                                    cal: item['calories'].toString(),
                                  );
                                },
                                itemCount: bloc.filteredQuery.length,
                                pagination: const SwiperPagination(
                                  builder: FractionPaginationBuilder(
                                    activeColor: Color(0xff3D6B7D),
                                    color: Color.fromARGB(191, 61, 107, 125),
                                    fontSize: 12,
                                    activeFontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 400, 20, 0),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xffA8483D),
                                      ),
                                      onPressed: () async {
                                        //==========save in storage ===========
                                        // print(currentIndex);
                                        getIt.get<DataLayer>().addToCart(
                                            item: bloc.items[currentIndex - 1]);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Successfully Added To Cart',
                                              style: TextStyle(
                                                  color: Color(0xff467283)),
                                            ),
                                            backgroundColor: Color(0xfff4f4f4),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                        bloc.add(SearchEvent());

                                        print(await OneSignal.User
                                            .getExternalId());
                                      },
                                      child: const Text(
                                        '+ Add To Cart',
                                        style:
                                            TextStyle(color: Color(0xfff4f4f4)),
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return const SizedBox(); //show nothing
                    })
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class CoffeeCard extends StatelessWidget {
  final String name;
  final double price;
  final String imgURL;
  final String cal;

  const CoffeeCard({
    super.key,
    required this.name,
    required this.price,
    required this.imgURL,
    required this.cal,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      //    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/star.svg',
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 32,
                  color: Color(0xffF4F4F4),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Center(
          child: Text(
            '${price.toString()} SAR',
            style: const TextStyle(fontSize: 16, color: Color(0xffF4F4F4)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('cal. $cal',
                style: const TextStyle(
                  color: Color.fromARGB(170, 244, 244, 244),
                )),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Image.network(
              imgURL,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }
}
