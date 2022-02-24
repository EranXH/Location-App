import 'package:location_app/bloc/location/location_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';
import '../widgets/calendar.dart';
import '../widgets/cards_slider.dart';


// the calendar view page which represent the state in the location bloc
// the widget is devided to two parts - Calendar and CardsSlider
class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  _CalendarViewState createState() {
    return _CalendarViewState();
  }
}

class _CalendarViewState extends State<CalendarView> {
  late LocationsBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LocationBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBar(currentIndex: 0),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), // here the desired height
          child: AppBar()),
      body: StreamBuilder(
          stream: _bloc.stringSelectedDate,
          builder:
              (BuildContext context, AsyncSnapshot<String> stringSelectedDate) {
            return StreamBuilder(
                stream: _bloc
                    .getDocumentsListStrem(stringSelectedDate.data.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData && !snapshot.hasError) {
                    return Column(
                      children: <Widget>[
                        Calendar(
                            bloc: _bloc,
                            stringSelectedDate:
                                stringSelectedDate.data.toString()),
                        CardsSlider(snapshot: snapshot)
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text("No Locations"),
                    );
                  }
                });
          }),
    );
  }
}
