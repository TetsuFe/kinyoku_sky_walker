import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/supplemental_count/supplemental_label/models/goal.dart';

import '../goal_repository.dart';

class SupplementalLabelNotifier with ChangeNotifier {
  SupplementalLabelNotifier(this.repository) : assert(repository != null) {
    label = repository.read();
  }

  final SupplementalLabelRepository repository;
  SupplementalLabel label;

  void update(String supplementalLabelText) {
    repository.update(supplementalLabelText);
    label = repository.read();
    notifyListeners();
  }
}

final ChangeNotifierProvider<SupplementalLabelNotifier>
    supplementalLabelNotifierProvider = ChangeNotifierProvider(
        (ref) => SupplementalLabelNotifier(SupplementalLabelRepository()));
