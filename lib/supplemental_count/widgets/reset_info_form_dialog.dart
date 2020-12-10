import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/common/confirm_action_dialog.dart';
import 'package:kinyoku_continue/supplemental_count/count_start_date_repository.dart';
import 'package:kinyoku_continue/supplemental_count/models/elapsed_time_notifier.dart';

class SupplementalResetInfoFormDialog extends StatefulWidget {
  @override
  _SupplementalResetInfoFormDialogState createState() =>
      _SupplementalResetInfoFormDialogState();
}

class _SupplementalResetInfoFormDialogState
    extends State<SupplementalResetInfoFormDialog> {
  DateTime resetDate;
  SupplementalCountStateDateRepository _repository;
  String validationErrorText;

  SupplementalElapsedTimeNotifier supplementalElapsedTimeNotifier;

  final _hoursInputController = TextEditingController();
  int inputHours() => int.parse(_hoursInputController.text);
  final _minutesInputController = TextEditingController();
  int inputMinutes() => int.parse(_minutesInputController.text);
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    supplementalElapsedTimeNotifier =
        supplementalElapsedTimeNotifierProvider.read(context);
    _repository = supplementalCountStateDateRepository.read(context);
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
                  'リセット時刻を入力してください。',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Text(
                  '＊こちらのリセットをしても禁欲のリセットにはなりませんのでご安心ください。',
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Text(
                  '＊補助カウンターの記録は履歴に残りません。',
                  style: TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'リセット時刻',
                  style: TextStyle(fontSize: 16),
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
                minDateTime: DateTime.now().subtract(const Duration(days: 59)),
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
              Align(
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () {
                    /// _submitでは別でリセット時刻を計算することになるので、若干この値はリセット記録とは異なることになる。
                    /// であるとしても、_openSharePromptDialogで使う分にはほぼ問題ないはず
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmToResetDialog(
                          title: '本当にリセットしますか？', okAction: submitCallBack),
                    );
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
            ],
          ),
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
    if (_repository.read() != null &&
        resetDate.isBefore(_repository.read().value)) {
      return ResetDateValidationError.resetDateBeforeStartDate;
    }
    _repository.reset(resetDate);
    supplementalElapsedTimeNotifier.reset(resetDate);
    return null;
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
