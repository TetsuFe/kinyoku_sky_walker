import 'package:flutter/material.dart';
import 'package:kinyoku_continue/calendar/memo/calendar_memo_date_adapter.dart';
import 'package:kinyoku_continue/calendar/memo/memo_form.dart';
import 'package:kinyoku_continue/calendar/memo/memo_repository.dart';

class MemoView extends StatelessWidget {
  MemoView({@required this.calendarDate, @required this.onSubmitCompleted});
  final DateTime calendarDate;
  final VoidCallback onSubmitCompleted;
  @override
  Widget build(BuildContext context) {
    print('memo build');
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('メモ'),
            FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                showMemoEditDialog(context);
              },
              child: const Text(
                'メモの編集',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
          Text(MemoRepository().read(
                  CalendarMemoDateAdapter().transferToMemoDate(calendarDate)) ??
              ''),
        ],
      ),
    );
  }

  void showMemoEditDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => MemoForm(
              calendarDate: calendarDate,
              onSubmitCompleted: onSubmitCompleted,
            ),
        barrierDismissible: false);
  }
}
