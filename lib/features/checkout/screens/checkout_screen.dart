import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../features/place_order/screens/place_order_screen.dart';
import '../../../services/cart.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/custom_button.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final searchController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: (() => Navigator.of(context).pop()),
          child: const Icon(
            Icons.cancel,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: TextFormField(
          //     controller: searchController,
          //     onChanged: (str) {},
          //     decoration: InputDecoration(
          //       hintText: 'Search',
          //       suffixIcon: const Icon(Icons.search),
          //       filled: true,
          //       fillColor: AppColors.grey,
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(20),
          //           borderSide: const BorderSide(color: Colors.black45)),
          //     ),
          //   ),
          // ),

          // The food list
          Expanded(
            child: Consumer<Cart>(builder: (context, cartProvider, _) {
              return ListView(
                children: [
                  Column(
                      children: cartProvider
                          .fetchCart()
                          .entries
                          .map((e) => Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColors.alabaster,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CachedNetworkImage(
                                          imageUrl: e.value.imageUrl,
                                          fit: BoxFit.fitHeight,
                                          placeholder: (context, count) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(e.key),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          // Text(e.value.totalAmount.toString()),
                                          Row(
                                            children: [
                                              FaIcon(FontAwesomeIcons.nairaSign,
                                                  color: Colors.black,
                                                  size: 12),
                                              Text(
                                                  "${cartProvider.fetchCart()[e.key]!.totalAmount}"),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            cartProvider.deleteFood(
                                                foodName: e.key);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              cartProvider.decrementFoodCount(
                                                  foodName: e.key,
                                                  amount: e.value.foodCost);
                                            },
                                            child: Text(
                                              '-',
                                              style: TextStyles.semiBold(
                                                  20, AppColors.black),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${cartProvider.fetchCart()[e.key]!.numberOfItems}',
                                            style: TextStyles.semiBold(
                                                20, AppColors.black),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              cartProvider.incrementFoodCount(
                                                  foodName: e.key,
                                                  amount: e.value.foodCost);
                                            },
                                            child: Text(
                                              '+',
                                              style: TextStyles.semiBold(
                                                  20, AppColors.black),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )))
                          .toList()),
                ],
              );
            }),
          ),

          // Check Out button
          Container(
            color: AppColors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<Cart>(
                    builder: (context, cartProvider, _) => Text(
                          '${cartProvider.numberOfItems()} items | '
                          '${cartProvider.fetchTotalAmount()} Naira',
                          style: TextStyles.semiBold(15, AppColors.black),
                        )),
                CustomButton(
                    buttonColor: AppColors.green,
                    radius: 20,
                    child: Row(
                      children: const [
                        Text("Order"),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                    function: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PlaceOrderScreen()));
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
