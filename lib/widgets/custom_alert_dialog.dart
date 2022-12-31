import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/f_auth.dart';
import '../utils/appstyles.dart';

void customAlertDialog(BuildContext context, dynamic provider) {
  showDialog(
    barrierDismissible: false,
      context: context,
      builder: (context) => Consumer<FAuth>(builder: (context, provider, ch) {

            return  AlertDialog(
             alignment: Alignment.center,
              content: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Row(),
                  const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.green,
                    ),
                  ),
                ],
              ),
            );
          }));
}
