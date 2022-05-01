import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Custom input text form field for editing and adding todoItems.

class CustomInputTextFormField extends StatelessWidget {
  final String valueKeyString;
  final String labelText;
  final void Function(String?)? onSaved;
  final String initialValue;
  final int maxLength;

  const CustomInputTextFormField({
    Key? key,
    required this.onSaved,
    required this.valueKeyString,
    required this.labelText,
    required this.initialValue,
    required this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 120),
      child: TextFormField(
        key: ValueKey(valueKeyString),
        decoration: InputDecoration(
          labelText: labelText,
        ),
        autocorrect: true,
        maxLines: null,
        textCapitalization: TextCapitalization.none,
        onSaved: onSaved,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "This field is required";
          }
          return null;
        },
        initialValue: initialValue,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
        ],
      ),
    );
  }
}
