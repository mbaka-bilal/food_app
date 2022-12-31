import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/utils/appstyles.dart';

import '../../../utils/app_images.dart';

class DashBoardSlider extends StatefulWidget {
  const DashBoardSlider({super.key});

  @override
  State<DashBoardSlider> createState() => _DashBoardSliderState();
}

class _DashBoardSliderState extends State<DashBoardSlider> {
  int index = 0;
  Timer? _timer;
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        if (index == 0) {
          index = 1;
        } else {
          index = 0;
        }
        _pageController.animateToPage(index,
            duration: const Duration(seconds: 1), curve: Curves.easeIn);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
      }
    }
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: _pageController,
          itemBuilder: ((context, index) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (index == 0)
                        ? 'INSTANT \nMEALS \nDELIVERED'
                        : 'GET CHEAP \nAND DELICIOUS \nFOODS',
                    style: TextStyles.semiBold(15, AppColors.black),
                  ),
                  ClipOval(
                    child: Image.asset(
                      AppImages.appLogo,
                      scale: 1,
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }
}
