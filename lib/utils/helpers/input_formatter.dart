import 'package:flutter/services.dart';

class CommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    String newText = '';

    // Check if the new value has a decimal point
    bool hasDecimal = text.contains('.');

    // Split the text into parts before and after the decimal point (if any)
    List<String> parts = text.split('.');

    // Format the part before the decimal point (if any) with commas
    if (parts.isNotEmpty) {
      String partBeforeDecimal = parts[0].replaceAll(',', '');
      String formattedPartBeforeDecimal = _addCommasToNumber(partBeforeDecimal);
      newText += formattedPartBeforeDecimal;
    }

    // Add the decimal point and format the part after the decimal point (if any)
    if (hasDecimal && parts.length > 1) {
      newText += '.${parts[1]}';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _addCommasToNumber(String value) {
    final regEx = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return value.replaceAllMapped(regEx, (Match match) => '${match[1]},');
  }
}
