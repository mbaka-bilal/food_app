import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_app/features/onboarding/login/screens/login_screen.dart';
import 'package:food_app/utils/app_images.dart';
import 'package:food_app/utils/appstyles.dart';
import 'package:food_app/utils/custom_route.dart';
import 'package:food_app/widgets/custom_button.dart';

import '../helpers/request_status.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen(
      {super.key,
      required this.status,
      required this.headerText,
      required this.subText,
      this.function});

  final Status status;
  final String headerText;
  final String subText;
  final Function? function;

  @override
  Widget build(BuildContext context) {
    const smallSpace = SizedBox(
      height: 10,
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50.0, horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: (status == Status.success)
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    CustomNavigation().back(context: context);
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: AppColors.black,
                                    size: 30,
                                  ),
                                ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset((status == Status.failure)
                                ? AppImages.error
                                : AppImages.success),
                            Text(
                              headerText,
                              style: TextStyles.semiBold(25, AppColors.black),
                            ),
                            smallSpace,
                            Text(
                              subText,
                              style: TextStyles.normal(14, AppColors.grey),
                            )
                          ],
                        ),
                        CustomButton(
                            radius: 10,
                            width: double.infinity,
                            height: 50,
                            buttonColor: AppColors.green,
                            child: const Text('Continue'),
                            function: () => {function!()})
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
