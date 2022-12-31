import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/features/onboarding/forgot_password/screens/forgot_password_screen.dart';
import '/features/onboarding/signup/screens/signup_screen.dart';
import '/utils/app_images.dart';
import '/utils/appstyles.dart';
import '/utils/custom_route.dart';
import '/utils/validator.dart';
import '/widgets/custom_alert_dialog.dart';
import '/widgets/custom_button.dart';
import '/widgets/custom_form.dart';
import '/services/f_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    const bigSpace = SizedBox(
      height: 20,
    );

    const smallSpace = SizedBox(
      height: 10,
    );
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: LayoutBuilder(
        builder: (context, boxConstraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: boxConstraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        AppImages.appLogo,
                        scale: 3,
                      ),
                    ),
                    bigSpace,
                    Text(
                      'Welcome back !',
                      style: TextStyles.semiBold(25, AppColors.black),
                    ),
                    smallSpace,
                    Text(
                      'Please log in to continue',
                      style: TextStyles.normal(15, AppColors.black),
                    ),
                    bigSpace,
                    CustomForm(
                      isHidden: false,
                      formFieldValidator: Validator.validateName,
                      textEditingController: emailController,
                      leading: const Icon(
                        Icons.person,
                        color: AppColors.black,
                      ),
                      width: double.infinity,
                      hint: 'Email',
                      hintStyle: TextStyles.normal(14, AppColors.grey),
                    ),
                    smallSpace,
                    CustomForm(
                      isHidden: true,
                      formFieldValidator: Validator.validatePassword,
                      textEditingController: passwordController,
                      leading: const Icon(
                        Icons.lock,
                        color: AppColors.black,
                      ),
                      width: double.infinity,
                      hint: 'Password',
                      hintStyle: TextStyles.normal(14, AppColors.grey),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () => CustomNavigation().push(
                                context: context,
                                route: MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen())),
                            child: Text(
                              'Forgot password?',
                              style: TextStyles.semiBold(15, AppColors.black),
                            ))),
                    bigSpace,
                    CustomButton(
                      height: 50,
                      radius: 10,
                      width: double.infinity,
                      buttonColor: AppColors.green,
                      function: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        final provider = context.read<FAuth>();
                        provider.login(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context);
                        customAlertDialog(context, provider);
                      },
                      child: const Text('Login'),
                      // buttonColor: Colors.red,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ",
                            style: TextStyles.normal(15, AppColors.grey)),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()));
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyles.semiBold(15, AppColors.black),
                            ))
                      ],
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
