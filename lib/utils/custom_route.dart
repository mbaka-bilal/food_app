import 'package:flutter/material.dart';

class CustomNavigation {
  void push({required BuildContext context, required Route route}) {
    Navigator.of(context).push(route);
  }

  void pushReplacement({required BuildContext context, required Route route}) {
    Navigator.of(context).pushReplacement(route);
  }

  void back({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}

class CustomRoute {
  Route downToUp(Widget page) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.easeIn;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(
      curve: curve,
    ));

    return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: ((context, animation, secondaryAnimation) =>
            SlideTransition(
              position: animation.drive(tween),
              child: page,
            )));
  }

  Route rightToLeft(Widget page) {
    const begin = Offset(1, 0);
    const end = Offset.zero;
    const curve = Curves.easeIn;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(
      curve: curve,
    ));

    return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: ((context, animation, secondaryAnimation) =>
            SlideTransition(
              position: animation.drive(tween),
              child: page,
            )));
  }

  Route leftToRight(Widget page) {
    const begin = Offset.zero;
    const end =  Offset(1, 0);
    const curve = Curves.easeIn;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(
      curve: curve,
    ));

    return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: ((context, animation, secondaryAnimation) =>
            SlideTransition(
              position: animation.drive(tween),
              child: page,
            )));
  }
}
