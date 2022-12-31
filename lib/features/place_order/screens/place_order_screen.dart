import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '/helpers/request_status.dart';

import '/features/coupon/screens/coupon_screen.dart';
import '/features/place_order/screens/congratulations_screen.dart';
import '/features/wallet/screens/my_wallet_screen.dart';
import '/services/cart.dart';
import '/services/f_coupon.dart';
import '/services/f_database.dart';
import '/services/f_payment.dart';
import '/utils/appstyles.dart';
import '/widgets/custom_button.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fPayment = FPayment();

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (() => Navigator.of(context).pop()),
          child: const Icon(
            Icons.cancel,
            color: Colors.black,
            size: 30,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CouponScreen()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            color: AppColors.alabaster,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.discount,
                                  color: AppColors.black,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text('Apply Coupon',
                                    style: TextStyles.semiBold(
                                        20, AppColors.black)),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.black, width: 2),
                                      borderRadius: BorderRadius.circular(360)),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const MyWallet()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            color: AppColors.alabaster,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.wallet,
                                  color: AppColors.black,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                FutureBuilder(
                                  future: FDatabase.fetchUserInfo(),
                                  builder: (context, snapShot) {
                                    if (snapShot.hasData) {
                                      Map<String, dynamic> data =
                                          snapShot.data as Map<String, dynamic>;
                                      return Row(
                                        children: [
                                          Text(
                                            'Wallet Amount ',
                                            style: TextStyles.semiBold(
                                                20, AppColors.black),
                                          ),
                                          FaIcon(FontAwesomeIcons.nairaSign,
                                              color: Colors.black, size: 16),
                                          Text('${data['balance']}',
                                              style: TextStyles.semiBold(
                                                  20, AppColors.black)),
                                        ],
                                      );
                                    } else {
                                      return SizedBox(
                                          width: 20,
                                          child: LinearProgressIndicator());
                                    }
                                  },
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.black, width: 2),
                                      borderRadius: BorderRadius.circular(360)),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Card(
                            elevation: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              color: AppColors.alabaster,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: TextStyles.normal(
                                            18, AppColors.black),
                                      ),
                                      Row(
                                        children: [
                                          FaIcon(FontAwesomeIcons.nairaSign,
                                              color: Colors.black, size: 15),
                                          Text(
                                            '${context.read<Cart>().fetchTotalAmount()}',
                                            style: TextStyles.normal(
                                                18, AppColors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Delivery fee',
                                        style: TextStyles.normal(
                                            18, AppColors.black),
                                      ),
                                      Row(
                                        children: [
                                          FaIcon(FontAwesomeIcons.nairaSign,
                                              color: Colors.black, size: 15),
                                          Text(
                                            '500',
                                            style: TextStyles.normal(
                                                18, AppColors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Service Tax (6.0%)',
                                        style: TextStyles.normal(
                                            18, AppColors.black),
                                      ),
                                      Row(
                                        children: [
                                          FaIcon(FontAwesomeIcons.nairaSign,
                                              color: Colors.black, size: 15),
                                          Text(
                                            '${(context.read<Cart>().fetchTotalAmount()) * 0.06}',
                                            style: TextStyles.normal(
                                                18, AppColors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Discount',
                                        style: TextStyles.semiBold(
                                            18, AppColors.black),
                                      ),
                                      Consumer<FCoupon>(
                                        builder:
                                            (context, fCouponProvider, _) =>
                                                Row(
                                          children: [
                                            FaIcon(FontAwesomeIcons.nairaSign,
                                                color: Colors.black, size: 15),
                                            Text(
                                              '${fCouponProvider.fetchDiscount() * context.read<Cart>().fetchTotalAmount()}',
                                              style: TextStyles.normal(
                                                  18, AppColors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: TextStyles.normal(
                                            18, AppColors.black),
                                      ),
                                      Consumer<FCoupon>(
                                        builder:
                                            (context, fCouponProvider, _) =>
                                                Row(
                                          children: [
                                            FaIcon(FontAwesomeIcons.nairaSign,
                                                color: Colors.black, size: 15),
                                            Text(
                                              '${(context.read<Cart>().fetchTotalAmount() + (context.read<Cart>().fetchTotalAmount() * 0.06) + 500) - fCouponProvider.fetchDiscount() * context.read<Cart>().fetchTotalAmount()}',
                                              style: TextStyles.normal(
                                                  18, AppColors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      // padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: AppColors.green,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'My Current Address',
                                    style:
                                        TextStyles.normal(14, AppColors.grey),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '10, Ell Street, Port Harcourt',
                                    style: TextStyles.semiBold(
                                        18, AppColors.black),
                                  )
                                ],
                              ),
                              const Spacer(),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Change',
                                    style: TextStyles.semiBold(
                                        18, AppColors.white),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Consumer<FCoupon>(
                              builder: (context, fCouponProvider, _) =>
                                  CustomButton(
                                      buttonColor: AppColors.green,
                                      width: double.infinity,
                                      height: 50,
                                      radius: 20,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Place Order - ',
                                              style: TextStyles.semiBold(
                                                  14, AppColors.black)),
                                          FaIcon(FontAwesomeIcons.nairaSign,
                                              color: Colors.black, size: 12),
                                          Text(
                                              ' ${(context.read<Cart>().fetchTotalAmount() + (context.read<Cart>().fetchTotalAmount() * 0.06) + 500) - fCouponProvider.fetchDiscount() * context.read<Cart>().fetchTotalAmount()}',
                                              style: TextStyles.semiBold(
                                                  14, AppColors.black)),
                                        ],
                                      ),
                                      function: () async {
                                        int amount = ((context
                                                        .read<Cart>()
                                                        .fetchTotalAmount() +
                                                    (context
                                                            .read<Cart>()
                                                            .fetchTotalAmount() *
                                                        0.06) +
                                                    500) -
                                                fCouponProvider
                                                        .fetchDiscount() *
                                                    context
                                                        .read<Cart>()
                                                        .fetchTotalAmount())
                                            .toInt();
                                        context
                                            .read<FPayment>()
                                            .updateStatus(Status.waiting);
                                        showDialog(
                                            context: context,
                                            builder: (bcontext) {
                                              var nav = Navigator.of(context);
                                              return AlertDialog(
                                                  content: Consumer<FPayment>(
                                                builder:
                                                    (context, provider, child) {
                                                  if (provider
                                                          .paymentStatus() ==
                                                      Status.loading) {
                                                    return Wrap(
                                                      children: const [
                                                        Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                      ],
                                                    );
                                                  }

                                                  if (provider
                                                          .paymentStatus() ==
                                                      Status.failure) {
                                                    return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(provider
                                                            .errorText()),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        CustomButton(
                                                            buttonColor:
                                                                Colors.red,
                                                            child: const Text(
                                                                'Back'),
                                                            function: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            })
                                                      ],
                                                    );
                                                  }

                                                  if (provider
                                                      .paymentStatus() ==
                                                      Status.success){

                                                  }

                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CustomButton(
                                                          buttonColor:
                                                              AppColors.green,
                                                          child: Row(
                                                            children: const [
                                                              Icon(
                                                                  Icons.wallet),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                  'Pay from wallet'),
                                                            ],
                                                          ),
                                                          function: () {
                                                            provider
                                                                .payWithWallet(
                                                                    context,
                                                                    amount);
                                                          }),
                                                      CustomButton(
                                                          buttonColor:
                                                              AppColors.green,
                                                          child: Row(
                                                            children: const [
                                                              Icon(Icons
                                                                  .payment),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                  'Pay with card'),
                                                            ],
                                                          ),
                                                          function: () async {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .pop();
                                                            fPayment.pay(
                                                                context,
                                                                amount * 100,
                                                                () async {
                                                              nav.push(MaterialPageRoute(
                                                                  builder:
                                                                      ((context) =>
                                                                          const CongratulationScreen())));
                                                              await FDatabase
                                                                  .addFoodRecord(
                                                                      context);
                                                            });
                                                          }),
                                                    ],
                                                  );
                                                },
                                              ));
                                            });
                                      }))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
