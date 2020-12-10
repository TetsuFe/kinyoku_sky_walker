import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class GoalMemoRepository {
  static const String goalMemoKey = 'goalMemoKey';

  Future<String> read() async {
    final sp = await SharedPreferences.getInstance();
    final storedText = sp.getString(goalMemoKey);
    return storedText != null ? storedText : '';
  }

  Future<void> save(String text) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(goalMemoKey, text);
  }
}
