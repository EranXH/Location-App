import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../bloc/location/location_bloc.dart';

// part of the state of the location bloc
// the calendar widget state would be rebulit just like the cardsSlider
// the widget sends event to the bloc - on date change
class Calendar extends StatelessWidget {
  final LocationsBloc bloc;
  final String stringSelectedDate;

  const Calendar(
      {Key? key, required this.bloc, required this.stringSelectedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateFormat('dd-MM-yyyy').parse(stringSelectedDate);

    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: selectedDate,
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) {
        // Use selectedDayPredicate to determine which day is currently selected.
        return isSameDay(selectedDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(selectedDate, selectedDay)) {
          // Call setState() when updating the selected day
          // "Sending" the event to the bloc
          bloc.changeSelectedDate(DateFormat('dd-MM-yyyy').format(selectedDay));
        }
      },
      onFormatChanged: (format) {}
    );
  }
}