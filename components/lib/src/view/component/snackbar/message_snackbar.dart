

import 'package:flutter/material.dart';

messageSnackBar(String message) => SnackBar(
  content: Text(message),
  duration: const Duration(seconds: 3),
);