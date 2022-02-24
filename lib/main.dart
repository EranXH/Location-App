import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location_app/bloc/location/location_provider.dart';

import './pages/add_form.dart';
import './pages/calendar_view.dart';

void main() {
  runApp(const LocationApp());
}

class LocationApp extends StatelessWidget {
  const LocationApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return MaterialApp(
              title: _title,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const Center(
                child: Text("Eror"),
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return LocationBlocProvider(
                child: MaterialApp(
              title: _title,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: '/calendar',
              routes: { // The app pages by route
                '/calendar': (context) =>
                    const CalendarView(), //CalendarView() - The Calendar Page,
                '/add_form': (context) => const AllFieldsForm(),
              },
            ));
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return MaterialApp(
            title: _title,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const Center(
              child: Text("Loding"),
            ),
          );
        });
  }
}
