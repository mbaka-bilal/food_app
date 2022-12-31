import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/features/onboarding/login/screens/login_screen.dart';

import '../../../../services/f_auth.dart';
import '../../../../utils/appstyles.dart';
import '../../../../../utils/validator.dart';
import '../../../../../widgets/custom_alert_dialog.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bigSpace = SizedBox(
      height: 20,
    );

    const smallSpace = SizedBox(
      height: 10,
    );
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final mobileNumberController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: LayoutBuilder(
          builder: (context, boxConstraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: boxConstraints.maxHeight),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Consumer<FAuth>(
                  builder: (context, provider, _) {
                    return Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Getting started',
                            style: TextStyles.semiBold(20, AppColors.black),
                          ),
                          smallSpace,
                          SizedBox(
                            width: boxConstraints.maxWidth / 2,
                            child: Text(
                              'Create an account with us to enjoy meals on demand',
                              textAlign: TextAlign.center,
                              style: TextStyles.normal(15, AppColors.black),
                            ),
                          ),
                          bigSpace,
                          const SizedBox(
                            height: 10,
                          ),
                          CustomForm(
                            formFieldValidator: Validator.validateName,
                            isHidden: false,
                            textEditingController: nameController,
                            leading: const Icon(
                              Icons.person,
                              color: AppColors.black,
                            ),
                            width: double.infinity,
                            hint: 'Name',
                            hintStyle: TextStyles.normal(14, AppColors.grey),
                          ),
                          smallSpace,
                          CustomForm(
                            formFieldValidator: Validator.validateEmail,
                            isHidden: false,
                            textEditingController: emailController,
                            leading: const Icon(
                              Icons.mail,
                              color: AppColors.black,
                            ),
                            width: double.infinity,
                            hint: 'Email',
                            hintStyle: TextStyles.normal(14, AppColors.grey),
                          ),
                          smallSpace,
                          CustomForm(
                            formFieldValidator: Validator.validateMobileNumber,
                            isHidden: false,
                            textEditingController: mobileNumberController,
                            leading: const Icon(
                              Icons.phone_android,
                              color: AppColors.black,
                            ),
                            width: double.infinity,
                            hint: 'Mobile',
                            hintStyle: TextStyles.normal(14, AppColors.grey),
                          ),
                          smallSpace,
                          CustomForm(
                            formFieldValidator: Validator.validatePassword,
                            textEditingController: passwordController,
                            isHidden: true,
                            leading: const Icon(
                              Icons.lock,
                              color: AppColors.black,
                            ),
                            width: double.infinity,
                            hint: 'Password',
                            hintStyle: TextStyles.normal(14, AppColors.grey),
                          ),
                          smallSpace,
                          CustomForm(
                            formFieldValidator: ((value) {
                              return Validator.validateConfirmPassword(
                                  value, passwordController.text);
                            }),
                            width: double.infinity,
                            isHidden: true,
                            textEditingController: confirmPasswordController,
                            leading: const Icon(
                              Icons.lock,
                              color: AppColors.black,
                            ),
                            hint: 'Confirm Password',
                            hintStyle: TextStyles.normal(14, AppColors.grey),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'By Signing up, you agree to our Terms',
                            style: TextStyles.semiBold(15, AppColors.black),
                          ),
                          bigSpace,
                          CustomButton(
                            height: 50,
                            radius: 10,
                            width: double.infinity,
                            buttonColor: AppColors.green,
                            function: () {
                              final nav = Navigator.of(context);
                              if (!formKey.currentState!.validate()) {
                                return;
                              }

                              final name = nameController.text;
                              final email = emailController.text;
                              final mobileNumber = mobileNumberController.text;
                              final password = passwordController.text;
                              // final confirmPassword =
                              //     confirmPasswordController.text;

                              provider.createUser(
                                  name, email, password, mobileNumber, context);
                              customAlertDialog(context, provider);
                            },
                            child: const Text('Sign up'),
                            // buttonColor: Colors.red,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? ",
                                  style: TextStyles.normal(15, AppColors.grey)),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyles.semiBold(
                                        15, AppColors.black),
                                  ))
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
