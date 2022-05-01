import 'package:flutter/material.dart';
import '../constants/strings.dart';
import '../helpers/date_time_helper.dart';

///Form field for user to choose a date for a todoItem during a new addition or editing.
class DateFormField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final TextEditingController textEditingController;

  DateFormField({
    Key? key,
    required this.onSaved,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const ValueKey(dateFormFieldName),
      controller: textEditingController,
      showCursor: false,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        final DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTimeHelper.formatStringToDateTime(
                  textEditingController.text) ??
              DateTimeHelper.today(),
          firstDate: DateTimeHelper.today(),
          lastDate: DateTimeHelper.today().add(const Duration(days: 365)),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDatePickerMode: DatePickerMode.day,
          locale: const Locale("en", "GB"),
        );
        if (date != null) {
          textEditingController.text =
              DateTimeHelper.formatDateTimeToString(date);
        }
      },
      onSaved: onSaved,
      readOnly: true,
      decoration: const InputDecoration(
        errorMaxLines: 2,
        labelText: dateFormFieldName,
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'This field is required';
        }
        return null;
      },
      autofocus: false,
    );
  }
}
