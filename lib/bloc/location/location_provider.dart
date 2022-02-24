import 'package:flutter/material.dart';
import 'location_bloc.dart';
export 'location_bloc.dart';

// the location bloc provider
class LocationBlocProvider extends InheritedWidget{
  final bloc = LocationsBloc();

  LocationBlocProvider({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(oldWidget) => true;

  static LocationsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<LocationBlocProvider>() as LocationBlocProvider).bloc;
  }
}