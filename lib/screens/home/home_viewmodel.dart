import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  String username = "User"; // nanti bisa ambil dari API / SharedPreferences
  int validInputs = 120;
  int pendingInputs = 15;
  int totalData = 135;
  int errors = 5;

  // contoh kalau ada update data
  void updateStats({int? valid, int? pending, int? total, int? error}) {
    if (valid != null) validInputs = valid;
    if (pending != null) pendingInputs = pending;
    if (total != null) totalData = total;
    if (error != null) errors = error;

    notifyListeners();
  }
}
