import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FCoupon extends ChangeNotifier {
  double _couponDiscount = 0.0;
  int _chosenIndex = 0;

  double fetchDiscount() {
    return _couponDiscount;
  }

  int fetchChosenIndex() {
    return _chosenIndex;

  }

  void updateChosenIndex(int index) {
    _chosenIndex = index;
    notifyListeners();
  }

  void updateDiscount(int discount) {
    _couponDiscount = discount / 100;
  }

  Stream<QuerySnapshot> fetchCoupon() {
    // try {
      return FirebaseFirestore.instance.collection('coupons').snapshots();
    // }catch (e){
    //  print ("error fetching info $e");
    //
    // }
  }
}