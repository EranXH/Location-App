import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../widgets/bottom_navigation_bar.dart';
import '../bloc/add_form/add_form_bloc.dart';


// create the page for the add location form
// contains the AddFormWidget which is the state of the form bloc
class AllFieldsForm extends StatelessWidget {
  const AllFieldsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
                bottomNavigationBar: const BottomBar(currentIndex: 1),
                appBar: PreferredSize(
                    preferredSize:
                        const Size.fromHeight(0), // here the desired height
                    child: AppBar()),
                floatingActionButton: FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: formBloc.submit,
                  icon: const Icon(Icons.send),
                  label: const Text('SUBMIT'),
                ),
                body: AddFormWidget(
                  formBloc: formBloc,
                )),
          );
        },
      ),
    );
  }
}
