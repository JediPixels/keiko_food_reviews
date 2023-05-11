import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/helper/format_dates.dart';
import 'package:keiko_food_reviews/logic/review_entry_edit_logic.dart';

class ReviewEntryEditDatePicker extends StatelessWidget {
  const ReviewEntryEditDatePicker({
    super.key,
    required ReviewEntryEditLogic reviewEntryEditLogic,
    required TextEditingController date,
    required ValueNotifier<String> reviewDateNotifier,
  })  : _reviewEntryEditLogic = reviewEntryEditLogic,
        _date = date,
        _reviewDateNotifier = reviewDateNotifier;

  final ReviewEntryEditLogic _reviewEntryEditLogic;
  final TextEditingController _date;
  final ValueNotifier<String> _reviewDateNotifier;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
      ),
      onPressed: () {
        _reviewEntryEditLogic.selectDate(context: context).then((selectedDate) {
          if (selectedDate.isNotEmpty) {
            _date.text = selectedDate;
            _reviewDateNotifier.value = selectedDate;
          }
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.calendar_today),
          const SizedBox(width: 16.0),
          ValueListenableBuilder(
            valueListenable: _reviewDateNotifier,
            builder: (
              BuildContext context,
              String reviewDate,
              Widget? widget,
            ) {
              return Text(
                FormatDates.dateFormatShortMonthDayYear(
                  '${_reviewEntryEditLogic.reviewEditModel.reviewDate}',
                ),
                style: Theme.of(context).textTheme.bodyLarge,
              );
            },
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
