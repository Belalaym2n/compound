import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class StepTwoContent extends StatefulWidget {
  StepTwoContent({
    super.key,
    required this.isSelected,
    required this.toggleDateSelection,
  });

  Function toggleDateSelection;
  Function isSelected;

  @override
  State<StepTwoContent> createState() => _StepTwoContentState();
}

class _StepTwoContentState extends State<StepTwoContent> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2040, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => widget.isSelected(day),
      onDaySelected: (selectedDay, focusedDay) {
        widget.toggleDateSelection(selectedDay);
        _focusedDay = selectedDay;
        setState(() {});
        print(selectedDay);
      },
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: true,
        selectedDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
    );
    ;
  }
}
