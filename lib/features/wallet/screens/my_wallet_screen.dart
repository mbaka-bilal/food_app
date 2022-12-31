import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/services/f_database.dart';
import '/services/f_payment.dart';
import '/utils/appstyles.dart';
import '/widgets/custom_button.dart';

class MyWallet extends StatelessWidget {
  const MyWallet({super.key});

  @override
  Widget build(BuildContext context) {
    FPayment fPayment = FPayment();
    var _formKey = GlobalKey<FormState>();
    String amount = "";
    TextEditingController amountController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: (() => Navigator.of(context).pop()),
          child: const Icon(
            Icons.cancel,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        StreamBuilder(
            stream: FDatabase.userInfoStream(),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 200,
                  color: AppColors.alabaster,
                  child: Text(
                    "Error",
                    style: TextStyles.semiBold(20, AppColors.black),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: 200,
                    color: AppColors.grey,
                    child: const Center(child: CircularProgressIndicator()));
              }

              if (snapshot.hasData) {
                DocumentSnapshot documentSnapshot =
                    snapshot.data as DocumentSnapshot;
                Map<String, dynamic> data =
                    documentSnapshot.data() as Map<String, dynamic>;

                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 200,
                  child: Card(
                    color: AppColors.alabaster,
                    elevation: 20,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Balance: N ${data['balance']}',
                            style: TextStyles.normal(18, AppColors.black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomButton(
                              height: 50,
                              width: double.infinity,
                              buttonColor: AppColors.green,
                              function: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Form(
                                          key: _formKey,
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                  hintText: 'Enter Amount'),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) =>
                                                  amount = value,
                                              validator: (str) {
                                                if (str!.isEmpty) {
                                                  return 'Field cannot by empty';
                                                }
                                                return null;
                                              },
                                              controller: amountController,
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          CustomButton(
                                            buttonColor: AppColors.green,
                                            function: () async {
                                              // print("validating success");
                                              if (!_formKey.currentState!
                                                  .validate()) {
                                                return;
                                              }

                                              // Navigator.of(context).pop();
                                              await fPayment.pay(context,
                                                  (int.tryParse(amount)! * 100),
                                                  () async {
                                                await FDatabase.updateBalance(
                                                    data['balance'] +
                                                        (int.tryParse(
                                                            amount)!));
                                              });
                                            },
                                            child: const Text('Add'),
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: const Text("Add Money"),
                            ),
                          )
                        ]),
                  ),
                );
              }
              return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 200,
                  color: AppColors.grey,
                  child: const Center(child: CircularProgressIndicator()));
            }))
      ]),
    );
  }
}
