import 'package:flutter/material.dart';
import 'package:recolo/utility/date_utility.dart';

class MonthView extends StatelessWidget {
  const MonthView({Key? key, required this.year, required this.month})
      : super(key: key);

  final int year;
  final int month;

  @override
  Widget build(BuildContext context) {
    var daysOfMonth = DateUtility.daysOfMonth(DateTime(year, month));
    final firstWeekday = daysOfMonth.first.weekday - 1;
    final rowsNeeded = ((firstWeekday + daysOfMonth.length) / 7).ceil();
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
      itemCount: rowsNeeded * 7,
      itemBuilder: (context, index) {
        final effectiveIndex = index - firstWeekday;
        //current grid day belongs to last month
        if (effectiveIndex < 0) return SizedBox();
        //current grid day belongs to next month
        if (effectiveIndex >= daysOfMonth.length) return SizedBox();
        //current grid day is in current month
        return Center(
          child: Text(daysOfMonth.elementAt(effectiveIndex).day.toString()),
        );
      },
    );
  }
}
