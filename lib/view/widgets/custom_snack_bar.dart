import 'package:flutter/material.dart';

SnackBar customSnackBar({
  required String text,
  required SnackBarType type,
}) {
  final Color? color;
  switch (type) {
    case SnackBarType.success:
      color = Colors.green;
    case SnackBarType.error:
      color = Colors.red;
    case SnackBarType.neutral:
      color = null;
      break;
  }

  return SnackBar(
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    elevation: 10,
    shape: const StadiumBorder(),
    margin: const EdgeInsets.all(10),
    content: Text(text),
  );
}

enum SnackBarType { success, error, neutral }
