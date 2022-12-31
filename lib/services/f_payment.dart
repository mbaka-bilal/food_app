import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import '../features/place_order/screens/congratulations_screen.dart';
import '../helpers/request_status.dart';
import '../services/f_database.dart';


class FPayment extends ChangeNotifier {
  final _publicKey = 'pk_test_9974aed0c07b9bd7a7a5a85b2e9a5abf10982c76';
  final _plugin = PaystackPlugin();
  Status _status = Status.success;
  String _errorText = '';

  FPayment() {
    _plugin.initialize(publicKey: _publicKey);
  }

  void initialize() {
    _plugin.initialize(publicKey: _publicKey);
  }

  void updateStatus(Status status) {
    _status = status;
    notifyListeners();
  }

  Status paymentStatus() {
    return _status;
  }

  String errorText() {
    return _errorText;
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> pay(
      BuildContext context, int amount, Function successFunction) async {
    // _status = Status.loading;
    // print("paying for thing");
    Charge charge = Charge()
      ..amount = amount
      ..reference = _getReference()
      // ..card = getCardF
      ..email = FirebaseAuth.instance.currentUser!.email;

    final CheckoutResponse checkOutResponse = await _plugin.checkout(
      context,
      charge: charge,
      method: CheckoutMethod.card,
    );

    if (checkOutResponse.status == true) {
      // print("running success function");
      successFunction();
    }
  }

  Future<void> payWithWallet(BuildContext context, int amount) async {
    _status = Status.loading;
    notifyListeners();

    Future<void> addRecord() async {
      await FDatabase.addFoodRecord(context);
    }

    try {
      var nav = Navigator.of(context);
      Map<String, dynamic>? userData = await FDatabase.fetchUserInfo();
      int currentBalance = userData!['balance'];

      if (currentBalance < amount) {
        _status = Status.failure;
        _errorText = 'Insufficient Balance';
        notifyListeners();
      } else {
        await FDatabase.updateBalance(currentBalance - amount);
        _status = Status.success;
        notifyListeners();
        addRecord();
        nav.push(MaterialPageRoute(
            builder: ((context) => const CongratulationScreen())));

      }
    } catch (e) {
      _status = Status.failure;
      _errorText = 'No Network';
      notifyListeners();
      // print("Error paying with wallet $e");
      // return Future.error();
    }
  }
}
