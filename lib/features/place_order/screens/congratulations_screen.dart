import 'package:flutter/material.dart';

import '/features/my_orders/screens/my_orders_screen.dart';
import '/utils/app_images.dart';
import '/utils/appstyles.dart';
import '/widgets/custom_button.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: WillPopScope(
          onWillPop: (() => Future.value(false)),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(),
                      ClipOval(
                        child: Image.asset(
                          AppImages.appLogo,
                          scale: 3,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Congratulation!',
                        style: TextStyles.semiBold(30, AppColors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Your Order is on the way',
                        style: TextStyles.normal(18, AppColors.grey),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                          width: double.infinity,
                          height: 50,
                          buttonColor: AppColors.green,
                          radius: 20,
                          child: Text('Track your order',
                              style: TextStyles.normal(18, AppColors.white)),
                          function: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: ((context) => const MyOrders())));
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
