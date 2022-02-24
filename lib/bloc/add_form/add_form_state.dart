part of 'add_form_bloc.dart';

// the state of the add form bloc
class AddFormWidget extends StatelessWidget {
  final AllFieldsFormBloc formBloc;

  const AddFormWidget({Key? key, required this.formBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBlocListener<AllFieldsFormBloc, String, String>(
      onSubmitting: (context, state) {
        LoadingDialog.show(context);
      },
      onSuccess: (context, state) {
        LoadingDialog.hide(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your location has been added')),
        );
      },
      onFailure: (context, state) {
        LoadingDialog.hide(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Faild to add your location')),
        );
      },
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              TimeFieldBlocBuilder(
                timeFieldBloc: formBloc.beginningTime,
                format: DateFormat('HH:mm'),
                initialTime: TimeOfDay.now(),
                decoration: const InputDecoration(
                  labelText: 'Beginning Time',
                  prefixIcon: Icon(Icons.access_time),
                ),
              ),
              TimeFieldBlocBuilder(
                timeFieldBloc: formBloc.endingTime,
                format: DateFormat('HH:mm'),
                initialTime: TimeOfDay.now(),
                decoration: const InputDecoration(
                  labelText: 'End Time',
                  prefixIcon: Icon(Icons.access_time),
                ),
              ),
              DateTimeFieldBlocBuilder(
                dateTimeFieldBloc: formBloc.date,
                format: DateFormat('dd-MM-yyyy'),
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
                decoration: const InputDecoration(
                  labelText: 'Date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.price,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Price',
                    prefixIcon: Icon(
                      Icons.attach_money,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}


