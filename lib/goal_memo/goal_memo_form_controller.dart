import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import 'goal_repository.dart';

final goalMemoFormControllerProvider =
    Provider((ref) => GoalMemoFormController());

class GoalMemoFormController {
  GoalMemoFormController() {
    setInitialSavedGoalMemo();
    _initStream();
    storedTextStream.listen(print);
  }

  final controller = TextEditingController(text: '');
  final _repository = GoalMemoRepository();
  BehaviorSubject<String> storedTextStreamController =
      BehaviorSubject<String>();
  Sink<String> get storedTextSink => storedTextStreamController;
  ValueStream<String> get storedTextStream => storedTextStreamController;

  void _initStream() async {
    final storedText = await _repository.read();
    storedTextSink.add(storedText);
  }

  void _sinkLatestStoredText(String text) async {
    final storedText = await _repository.read();
    storedTextSink.add(storedText);
  }

  void save() {
    _repository.save(controller.text);
    _sinkLatestStoredText(controller.text);
  }

  Future<void> setInitialSavedGoalMemo() async {
    controller.text = await _repository.read();
  }

  void dispose() {
    controller.dispose();
    storedTextStreamController.close();
  }
}
