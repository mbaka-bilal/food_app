import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.child,
      required this.function,
      this.buttonColor,
      this.width,
      this.height, this.radius});

  final Widget child;
  final Function? function;
  final Color? buttonColor;
  final double? width;
  final double? height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: (function == null)
            ? null
            : () {
                function!();
              },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            (radius == null) ? null : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!)
          ),
          ),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          }
          return buttonColor;
        },
        
        ),
        
        ),
        child: child,
      ),
    );
  }
}
