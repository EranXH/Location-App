import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../repository/location_repository.dart';
import '../../widgets/loading_dialog.dart';

part 'add_form_state.dart';

// the bloc for the form fields
class AllFieldsFormBloc extends FormBloc<String, String> {

  // creating the inputs of the form
  final beginningTime = InputFieldBloc<TimeOfDay?, Object>(
    initialValue: null,
    validators: [FieldBlocValidators.required],
    asyncValidatorDebounceTime: const Duration(milliseconds: 100),
  );
  final endingTime = InputFieldBloc<TimeOfDay?, Object>(
    initialValue: null,
    validators: [FieldBlocValidators.required],
    asyncValidatorDebounceTime: const Duration(milliseconds: 100),
  );
  final date = InputFieldBloc<DateTime?, Object>(
    initialValue: null,
    validators: [FieldBlocValidators.required],
    asyncValidatorDebounceTime: const Duration(milliseconds: 100),
  );
  final price = TextFieldBloc(
    initialValue: '',
    validators: [FieldBlocValidators.required],
    asyncValidatorDebounceTime: const Duration(milliseconds: 100),
  );

  // Real time validator for the beginnig time
  Validator<TimeOfDay?> _beginningTimeValidator(
    InputFieldBloc endingTime,
  ) {
    return (TimeOfDay? beginningTime) {
      if (beginningTime != null && endingTime.value != null) {
        if ((beginningTime.hour > endingTime.value!.hour) ||
            (beginningTime.hour == endingTime.value!.hour &&
                beginningTime.minute >= endingTime.value!.minute)) {
          return 'Beginning Time must be earlier then End Time';
        }
        return null;
      }
      return null;
    };
  }

  // Real time validator for the ending time
  Validator<TimeOfDay?> _endingTimeValidator(
    InputFieldBloc beginningTime,
  ) {
    return (TimeOfDay? endingTime) {
      if (endingTime != null && beginningTime.value != null) {
        if ((endingTime.hour < beginningTime.value!.hour) ||
            (endingTime.hour == beginningTime.value!.hour &&
                endingTime.minute <= beginningTime.value!.minute)) {
          return 'End Time must be later then Beginning Time';
        }
        return null;
      }
      return null;
    };
  }
  
  // constract the form bloc
  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [beginningTime, endingTime, date, price]);

    // adding the validators
    beginningTime
      ..addValidators([_beginningTimeValidator(endingTime)])
      ..subscribeToFieldBlocs([endingTime]);
    endingTime
      ..addValidators([_endingTimeValidator(beginningTime)])
      ..subscribeToFieldBlocs([beginningTime]);
  }

  final _repository = LocationRepository();

  //clear the form on submit success
  void onSuccess() {
    beginningTime.clear();
    endingTime.clear();
    date.clear();
    price.clear();
    emitSuccess(canSubmitAgain: true);
  }

  // function which validate that the added location times arent overlaping with the exsisting ones
  bool checkTimeOverlap(
      var docListMap, DateTime beginningDateTime, DateTime endDateTime) {
    return docListMap.forEach((element) {
      Timestamp elementBegining = element['beginningTime'] as Timestamp;
      Timestamp elementEnding = element['endingTime'] as Timestamp;

      if (max(Timestamp.fromDate(beginningDateTime).seconds,
              elementBegining.seconds) <=
          min(Timestamp.fromDate(endDateTime).seconds, elementEnding.seconds)) {
        beginningTime.addFieldError('Time range already exists for this date');
        endingTime.addFieldError('Time range already exists for this date');
        return true;
      }
    });
  }

  // on clickng the submit button validate the date and send it in the correct form for it to be saved
  @override
  void onSubmitting() async {
    try {
      DateTime beginningDateTime = DateTime(
          date.value!.year,
          date.value!.month,
          date.value!.day,
          beginningTime.value!.hour,
          beginningTime.value!.minute);
      DateTime endDateTime = DateTime(date.value!.year, date.value!.month,
          date.value!.day, endingTime.value!.hour, endingTime.value!.minute);

      DocumentSnapshot exsistingDoc = await _repository
          .getDocument(DateFormat('dd-MM-yyyy').format(date.value!));

      if (exsistingDoc.data().toString() != 'null') {
        Map<String, dynamic> docMap =
            exsistingDoc.data() as Map<String, dynamic>;
        var docListMap = docMap.values.toList();

        if (!checkTimeOverlap(docListMap, beginningDateTime, endDateTime)) {
          _repository.updateDocument(beginningDateTime, endDateTime,
              int.parse(price.value), (docListMap.length + 1).toString());
          onSuccess();
        } else {
          emitFailure();
        }
      } else {
        _repository.setDocument(
            beginningDateTime, endDateTime, int.parse(price.value));
        onSuccess();
        
      }
    } 
    catch (e) { // on eror emit a failure
      emitFailure();
    }
  }
}
