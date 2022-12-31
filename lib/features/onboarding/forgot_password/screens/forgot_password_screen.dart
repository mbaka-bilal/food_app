import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/services/f_auth.dart';
import '/utils/appstyles.dart';
import '/utils/custom_route.dart';
import '/utils/validator.dart';
import '/widgets/custom_alert_dialog.dart';
import '/widgets/custom_button.dart';
import '/widgets/custom_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bigSpace = SizedBox(
      height: 20,
    );

    const smallSpace = SizedBox(
      height: 10,
    );
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: (() =>
                                  CustomNavigation().back(context: context)),
                              child: const Icon(
                                Icons.cancel,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                            bigSpace,
                            bigSpace,
                            Text('Recover Password',
                                style: TextStyles.semiBold(
                                  30,
                                  AppColors.black,
                                )),
                            bigSpace,
                            SizedBox(
                              width: constraints.maxWidth / 1.5,
                              child: Text(
                                'Enter the email specified during registration, '
                                'you will recieve a link to reset the password',
                                style: TextStyles.normal(14, AppColors.grey),
                              ),
                            ),
                            bigSpace,
                            Form(
                              key: formKey,
                              child: CustomForm(
                                  isHidden: false,
                                  formFieldValidator: Validator.validateEmail,
                                  textEditingController: emailController,
                                  width: double.infinity,
                                  hint: 'Email',
                                  hintStyle: TextStyles.normal(
                                    14,
                                    AppColors.grey,
                                  )),
                            ),
                          ],
                        ),
                        CustomButton(
                          function: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            final provider = context.read<FAuth>();
                            provider.forgotPassword(
                                emailController.text, context);
                            customAlertDialog(context, provider);
                          },
                          buttonColor: AppColors.green,
                          width: double.infinity,
                          height: 50,
                          radius: 10,
                          child: const Text('Continue'),
                        )
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
