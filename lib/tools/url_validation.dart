
import 'package:flutter/material.dart';

class UrlValidationHelper{

  bool validateUrl(TextEditingController urlController ) {
    final userInput = urlController.text.trim();

    return !Uri.parse(userInput).isAbsolute;
  }

}