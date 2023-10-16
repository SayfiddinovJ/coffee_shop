import 'package:flutter/services.dart';

class PriceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String formatted = newValue.text;

    // Remove all non-numeric characters
    formatted = formatted.replaceAll(RegExp(r'[^0-9]'), '');

    // Add thousand separators
    if (formatted.length > 3) {
      formatted = '${formatted.substring(0, formatted.length - 3)} ${formatted.substring(formatted.length - 3)}';
    }
    if (formatted.length > 7) {
      formatted = '${formatted.substring(0, formatted.length - 7)} ${formatted.substring(formatted.length - 7)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}