import 'dart:math';
import 'package:flutter/material.dart';

class TambolaGameProvider with ChangeNotifier {
  List<List<int>> _ticket = [];
  final List<int> _calledNumbers = [];

  TambolaGameProvider() {
    _generateTicket();
  }

  List<List<int>> get ticket => _ticket;
  List<int> get calledNumbers => _calledNumbers;

  void _generateTicket() {
    _ticket = List.generate(3, (_) => List.filled(9, 0));
    Random rand = Random();
    for (int i = 0; i < 3; i++) {
      List<int> row = _ticket[i];
      Set<int> used = {};
      while (used.length < 5) {
        int num = rand.nextInt(90) + 1;
        if (!used.contains(num)) {
          row[used.length] = num;
          used.add(num);
        }
      }
      row.sort();
    }
    notifyListeners();
  }

  void callNumber() {
    if (_calledNumbers.length < 90) {
      int num;
      do {
        num = Random().nextInt(90) + 1;
      } while (_calledNumbers.contains(num));
      _calledNumbers.add(num);
      notifyListeners();
    }
  }
}
