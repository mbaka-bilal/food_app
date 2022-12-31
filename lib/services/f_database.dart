import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/request_status.dart';
import '../services/cart.dart';


class FDatabase extends ChangeNotifier {
  final RequestStatus _requestStatus = RequestStatus(status: Status.loading);
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  bool _search = false;
  String _searchText = '';

  RequestStatus showRequestStatus() {
    return _requestStatus;
  }

  void updateSearch(bool status) {
    _search = status;
    // print ("the status is $status");
    notifyListeners();
  }

  void updateSearchString(String text) {
    _searchText = text;
    notifyListeners();
  }

  Stream<QuerySnapshot> fetchFoods() {
    // print("the state of search is $_search");
    if (_search == true) {
      return _firebaseFirestore
          .collection('foods')
          .where('name', isGreaterThanOrEqualTo: _searchText)
          .where('name', isLessThan: "${_searchText}z")
          .snapshots();
    }

    return _firebaseFirestore.collection('foods').snapshots();
  }

  static Future<Map<String, dynamic>?> fetchUserInfo() async {
    try {
      final userInfo = await _firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      // print ("user info is ${userInfo.data()}");
      return userInfo.data();
    } catch (e) {
      // print("unable to fetch user info $e");
      return Future.error({});
    }
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> userInfoStream() {
    return _firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots(
          includeMetadataChanges: true,
        );
  }

  static Future<bool> addUser(String name, String phoneNumber) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'name': name, 'phone_number': phoneNumber,'balance':0});

      // await _firebaseFirestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders').

      return true;
    } catch (e) {
      // print("error uploading user info");
      return false;
    }
  }

  static Future<void> addFoodRecord(BuildContext context) async {
    List<String> foodIDs = [];
    Map<String, dynamic> foods = context.read<Cart>().fetchCart();

    for (var e in foods.entries) {
      foodIDs.add(e.value.foodID);
    }

    try {
      await _firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('orders')
          .add({'orders': foodIDs, 'date': Timestamp.fromDate(DateTime.now())});
    } catch (e) {
      // print("Error trying to upload purchase info ${e}");
    }
  }

  static Stream<QuerySnapshot> fetchOrders() {
    return _firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('orders')
        .snapshots();
  }

  static Future<Map<String, dynamic>> fetchSingleFoodInformation(
      String docID) async {
    try {
      DocumentSnapshot documentSnapShot =
          await _firebaseFirestore.collection('foods').doc(docID).get();
      return documentSnapShot.data() as Map<String, dynamic>;
    } catch (e) {
      // print("unable to fetch data $e");
      return Future.error({});
    }
  }

  static Future<void> updateBalance(int newBalance) async {
    try {
      _firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'balance': newBalance});
    } catch (e) {
      // print("Error updating balance $e");
    }
  }
}
