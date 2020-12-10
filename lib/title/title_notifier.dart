import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/title/models/title.dart';

class TitleNotifier extends ValueNotifier<KinyokuTitle> {
  TitleNotifier() : super(null);

  @override
  KinyokuTitle get value => super.value;

  @override
  set value(KinyokuTitle newValue) {
    super.value = newValue;
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

final titleNotifierProvider = ChangeNotifierProvider((ref) => TitleNotifier());
