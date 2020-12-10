import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/calendar/calender_prohibited_mark_notifier.dart';
import 'package:kinyoku_continue/common/confirm_action_dialog.dart';
import 'package:kinyoku_continue/count_history/count_history_average_notifier.dart';
import 'package:kinyoku_continue/count_history/count_history_list_notifier.dart';
import 'package:kinyoku_continue/counter/count_start_date_repository.dart';
import 'package:kinyoku_continue/counter/models/elapsed_time.dart';
import 'package:kinyoku_continue/counter/models/elapsed_time_notifier.dart';
import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time.dart';
import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time_monthly_carousel_notifier.dart';
import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time_sum_notifier.dart';
import 'package:kinyoku_continue/share/share_prompt_dialog.dart';

class ResetInfoFormDialog extends StatefulWidget {
  @override
  _ResetInfoFormDialogState createState() => _ResetInfoFormDialogState();
}

class _ResetInfoFormDialogState extends State<ResetInfoFormDialog> {
  DateTime resetDate;
  CountStateDateRepository _repository;
  String validationErrorText;

  ElapsedTimeNotifier elapsedTimeNotifier;
  CountHistoryListNotifier countHistoryListNotifier;
  CountHistoryTop5ListNotifier countHistoryTop5ListNotifier;
  CountHistoryAverageNotifier countHistoryAverageNotifier;
  ProhibitedMatterTimeSumNotifier prohibitedMatterTimeSumNotifier;
  ProhibitedMatterTimeMonthlyCarouselNotifier
      prohibitedMatterTimeMonthlyCarouselNotifier;
  CalenderProhibitedMarkDaysNotifier calenderProhibitedMarkDaysNotifier;

  final _hoursInputController = TextEditingController(text: '0');
  int inputHours() => int.parse(_hoursInputController.text);
  final _minutesInputController = TextEditingController(text: '0');
  int inputMinutes() => int.parse(_minutesInputController.text);
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    elapsedTimeNotifier = elapsedTimeNotifierProvider.read(context);
    countHistoryListNotifier = countHistoryListNotifierProvider.read(context);
    countHistoryAverageNotifier =
        countHistoryAverageNotifierProvider.read(context);
    countHistoryTop5ListNotifier =
        countHistoryTop5ListNotifierProvider.read(context);
    prohibitedMatterTimeSumNotifier =
        prohibitedMatterTimeSumNotifierProvider.read(context);
    prohibitedMatterTimeMonthlyCarouselNotifier =
        prohibitedMatterTimeMonthlyCarouselNotifierProvider.read(context);
    calenderProhibitedMarkDaysNotifier =
        calenderProhibitedMarkDaysNotifierProvider.read(context);

    _repository = countStateDateRepositoryProvider.read(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('リセット情報の入力'),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    '禁欲に失敗した時刻（リセット時刻）を入力してください。',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'リセット時刻',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                validationErrorText != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          validationErrorText,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      )
                    : Container(),
                DateTimePickerWidget(
                  minDateTime:
                      DateTime.now().subtract(const Duration(days: 59)),
                  maxDateTime: DateTime.now().add(const Duration(minutes: 5)),
                  pickerTheme: DateTimePickerTheme(
                    confirm: Container(),
                    backgroundColor: Colors.transparent,
                    itemTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  locale: DateTimePickerLocale.jp,
                  onChange: (date, _) {
                    setState(() {
                      resetDate = date;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    '禁欲発散にかかった時間',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'この時間を記録する必要がない方は、０時間０分のまま確認ボタンを押してください。',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: _hoursInputController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return '数値を設定してください。';
                            }
                            if (int.parse(value) > 600) {
                              return '600までにしてください。';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Text('時間'),
                      Expanded(
                        child: TextFormField(
                          controller: _minutesInputController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return '数値を設定してください。';
                            }
                            if (int.parse(value) > 59) {
                              return '59までにしてください。';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Text('分'),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    onPressed: () {
                      /// _submitでは別でリセット時刻を計算することになるので、若干この値はリセット記録とは異なることになる。
                      /// であるとしても、_openSharePromptDialogで使う分にはほぼ問題ないはず
                      final elapsedTimeAtReset =
                          elapsedTimeNotifier.getElapsedTime();
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmToResetDialog(
                            title: '本当にリセットしますか？', okAction: submitCallBack),
                      ).whenComplete(
                          () => _openSharePromptDialog(elapsedTimeAtReset));
                    },
                    child: const Text(
                      '確認',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'キャンセル',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ]),
        ),
      ],
    );
  }

  void submitCallBack() {
    final error = _submit();
    if (error == ResetDateValidationError.resetDateBeforeStartDate) {
      setState(() {
        validationErrorText = '開始時刻よりも前の時刻は設定できません。';
      });
    } else if (error ==
        ResetDateValidationError.prohibitedMatterTimeValueError) {
      return;
    } else {
      Navigator.of(context).pop();
    }
  }

  ResetDateValidationError _submit() {
    resetDate ??= DateTime.now();
    if (_formKey.currentState.validate()) {
      prohibitedMatterTimeSumNotifierProvider.read(context).add(
          ProhibitedMatterTime(
              hours: int.parse(_hoursInputController.text),
              minutes: int.parse(_minutesInputController.text),
              date: resetDate));
    } else {
      return ResetDateValidationError.prohibitedMatterTimeValueError;
    }

    if (_repository.read() != null &&
        resetDate.isBefore(_repository.read().value)) {
      return ResetDateValidationError.resetDateBeforeStartDate;
    }
    _repository.reset(resetDate);
    elapsedTimeNotifier.reset(resetDate);
    countHistoryListNotifier.reload();
    countHistoryTop5ListNotifier.reload();
    countHistoryAverageNotifier.reload();
    prohibitedMatterTimeSumNotifier.reload();
    prohibitedMatterTimeMonthlyCarouselNotifier.reload();
    calenderProhibitedMarkDaysNotifier.reload();
    return null;
  }

  void _openSharePromptDialog(ElapsedTime elapsedTimeAtReset) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => SharePromptDialog(
        elapsedTimeAtReset: elapsedTimeAtReset,
        size: MediaQuery.of(context).size,
      ),
    );
  }

  @override
  void dispose() {
    _hoursInputController.dispose();
    _minutesInputController.dispose();
    super.dispose();
  }
}

enum ResetDateValidationError {
  resetDateBeforeStartDate,
  prohibitedMatterTimeValueError
}
