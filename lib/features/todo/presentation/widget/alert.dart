import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  const ErrorAlert({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ошибка'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(text),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Ок'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}