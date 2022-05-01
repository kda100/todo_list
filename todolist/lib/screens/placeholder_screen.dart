import 'package:flutter/material.dart';

import '../constants/strings.dart';

///Widget to hold placeholder widgets in a material scaffold.
///used when app is loading todoList and if an error occurs during its attempt to retrieve.

class PlaceholderScreen extends StatelessWidget {
  final Widget placeholder;

  const PlaceholderScreen({
    Key? key,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appTitle)),
      body: placeholder,
    );
  }
}
