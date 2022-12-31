import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/show_all.dart';
import '../widgets/food_card.dart';

import '../../../features/checkout/screens/checkout_screen.dart';
import '../../../features/dashboard/widgets/dashboard_slider.dart';
import '../../../helpers/request_status.dart';
import '../../../services/f_database.dart';
import '../../../services/cart.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/status_screen.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      children: [
                        //Begin AppBar
                        SafeArea(
                          child: SizedBox(
                            height: constraints.maxHeight / 6,
                            child: Stack(
                              children: [
                                Container(
                                  color: AppColors.green,
                                  height: constraints.maxHeight / 10,
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                if (scaffoldKey
                                                    .currentState!.hasDrawer) {
                                                  if (scaffoldKey.currentState!
                                                      .isDrawerOpen) {
                                                    scaffoldKey.currentState!
                                                        .closeDrawer();
                                                  } else {
                                                    scaffoldKey.currentState!
                                                        .openDrawer();
                                                  }
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.menu,
                                                color: AppColors.black,
                                              )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          FutureBuilder(
                                              future: FDatabase.fetchUserInfo(),
                                              builder: (context, snapShot) {
                                                Map<String, dynamic>? userInfo =
                                                    snapShot.data;

                                                if (snapShot.hasError) {
                                                  return Text(
                                                    "Hello ",
                                                    style: TextStyles.fw400(
                                                        14, AppColors.white),
                                                  );
                                                }

                                                if (snapShot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Text(
                                                    "Hello ",
                                                    style: TextStyles.fw400(
                                                        14, AppColors.white),
                                                  );
                                                }

                                                return Text(
                                                  "Hello ${userInfo!['name']}",
                                                  style: TextStyles.fw400(
                                                      14, AppColors.white),
                                                );
                                              }),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.notifications,
                                              color: AppColors.greyLines,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CheckoutScreen()));
                                            },
                                            icon: Stack(
                                              children: [
                                                const Icon(
                                                  Icons.shopping_cart,
                                                  color: AppColors.greyLines,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                        AppColors.black,
                                                    child: Consumer<Cart>(
                                                        builder: (context,
                                                            cartProvider, _) {
                                                      return Text(
                                                          '${cartProvider.numberOfItems()}',
                                                          style: TextStyles
                                                              .semiBold(
                                                                  17,
                                                                  AppColors
                                                                      .white));
                                                    }),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Positioned.fill(
                                  // bottom: 0,

                                  // top: 10,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      width: constraints.maxWidth / 1.2,
                                      padding: const EdgeInsets.only(top: 50),
                                      child: TextFormField(
                                        controller: searchController,
                                        onChanged: (str) {
                                          // Provider.of<FDatabase>(context, listen: false).updateSearch(true,);
                                          if (str.isEmpty || str == "") {
                                            print("empty");
                                            context
                                                .read<FDatabase>()
                                                .updateSearch(false);
                                            context
                                                .read<FDatabase>()
                                                .updateSearchString("");
                                          } else {
                                            print("not empty");
                                            context
                                                .read<FDatabase>()
                                                .updateSearch(true);
                                            context
                                                .read<FDatabase>()
                                                .updateSearchString(str);
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Search',
                                          suffixIcon: const Icon(Icons.search),
                                          filled: true,
                                          fillColor: AppColors.white,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.black45)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //End AppBar

                        // Column(
                        //   children: [
                        //     GridView.builder(
                        //         physics: ScrollPhysics(),
                        //         shrinkWrap: true,
                        //         gridDelegate:
                        //             SliverGridDelegateWithFixedCrossAxisCount(
                        //                 crossAxisCount: 2),
                        //         itemCount: 10,
                        //         itemBuilder: ((context, index) => Container(
                        //               width: 50,
                        //               height: 50,
                        //               color: Colors.red,
                        //             )))
                        //   ],
                        // )

                        Consumer<ShowAll>(
                          builder: (context, provider, child) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (provider.fetchStatus() == false)
                                const SizedBox(
                                    height: 150, child: DashBoardSlider()),
                              (provider.fetchStatus() == false)
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Food & Groceries',
                                            style: TextStyles.normal(
                                                18, AppColors.black),
                                          ),
                                          const Spacer(),
                                          TextButton(
                                              onPressed: () {
                                                provider.updateStatus();
                                              },
                                              child: const Text('View All'))
                                        ],
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                          onPressed: () {
                                            provider.updateStatus();
                                          },
                                          icon:
                                              const Icon(Icons.arrow_back_ios)),
                                    ),
                              Consumer<FDatabase>(
                                builder: (context, provider, _) =>
                                    StreamBuilder<QuerySnapshot>(
                                  stream: provider.fetchFoods(),
                                  builder: (context, asyncSnapshot) {
                                    if (asyncSnapshot.hasError) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const StatusScreen(
                                                      status: Status.failure,
                                                      headerText:
                                                          "Unknown Error",
                                                      subText: "Error")));
                                    }

                                    if (asyncSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }

                                    return GridView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2),
                                        itemCount:
                                            asyncSnapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          final data =
                                              asyncSnapshot.data!.docs[index];
                                          return FoodInfoCard(
                                            id: data.id,
                                            name: data['name'],
                                            cost: data['cost'],
                                            imageUrl: data['image_url'],
                                          );
                                        });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              )),
    );
  }
}
