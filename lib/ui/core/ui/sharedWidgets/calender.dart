import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged; // Callback Function

  CalendarWidget({
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: CalendarTimeline(
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(const Duration(days: 360)),
        lastDate: DateTime.now().add(const Duration(days: 360)),
        onDateSelected: (date) {
          setState(() {
            selectedDate = date;
          });
          widget.onDateChanged(selectedDate); // Call the callback function
        },
        dotColor: Colors.white,
        dayColor: Colors.black26,
        activeDayColor: Colors.white,
        activeBackgroundDayColor: AppColors.primary,
        locale: 'en_ISO',
      ),
    );
  }
}
