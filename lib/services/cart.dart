import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  Map<String, FoodInformation> _cart = {};
  int _totalAmount = 0;

  void addToList(
      {required String foodName,
      required String foodID,
      required int amount,
      required String imageUrl}) {
    if (_cart.containsKey(foodName)) {
      _cart[foodName]!.numberOfItems++;
      _cart[foodName]!.totalAmount = _cart[foodName]!.totalAmount + amount;
      _totalAmount = _totalAmount + amount;
    } else {
      _cart[foodName] = FoodInformation(
          numberOfItems: 1,
          foodID: foodID,
          totalAmount: amount,
          imageUrl: imageUrl,
          foodCost: amount);
      _totalAmount = _totalAmount + amount;
    }
    notifyListeners();  
  }

  void incrementFoodCount({required String foodName, required int amount}) {
    _cart[foodName]!.numberOfItems++;
    _cart[foodName]!.totalAmount = _cart[foodName]!.totalAmount + amount;
    _totalAmount = _totalAmount + amount;
    notifyListeners();
  }

  void decrementFoodCount({required String foodName, required int amount}) {
    if (_cart[foodName]!.numberOfItems == 1) {
      deleteFood(foodName: foodName);
    }
    _cart[foodName]!.numberOfItems--;
    _cart[foodName]!.totalAmount = _cart[foodName]!.totalAmount - amount;
    _totalAmount = _totalAmount - amount;
    notifyListeners();
  }

  void deleteFood({required String foodName}) {
    _totalAmount = _totalAmount - _cart[foodName]!.totalAmount;
    _cart.remove(foodName);
    notifyListeners();
  }

  int numberOfItems() {
    return _cart.length;
  }

  int fetchTotalAmount() {
    return _totalAmount;
  }

  Map<String, FoodInformation> fetchCart() {
    return _cart;
  }
}

class FoodInformation {
  int numberOfItems;
  int totalAmount;
  String imageUrl;
  final String foodID;
  final int foodCost;

  FoodInformation( {
    required this.foodID,
    required this.numberOfItems,
    required this.totalAmount,
    required this.imageUrl,
    required this.foodCost,
  });

  void updateNumberOfItems(int value) {
    numberOfItems = value;
  }
}
