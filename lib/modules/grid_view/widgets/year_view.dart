import 'package:flutter/material.dart';
import 'package:recolo/modules/grid_view/widgets/month_view.dart';

class YearView extends StatelessWidget {
  const YearView({Key? key, required this.year}) : super(key: key);

  final int year;

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final isCurrentYear = currentDate.year == year;
    final startingMonth = isCurrentYear ? currentDate.month : 12;
    return ListView.builder(
      itemCount: startingMonth,
      itemBuilder: (context, index) => MonthView(
        year: year,
        month: index + 1,
      ),
      reverse: true,
      shrinkWrap: true,
    );
  }
}
