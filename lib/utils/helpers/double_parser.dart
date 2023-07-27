double parseStringToDouble(String value) {
  // Remove commas from the string
  String cleanedValue = value.replaceAll(',', '');

  // Parse the cleaned string into a double
  double result = double.tryParse(cleanedValue) ?? 0.0;

  return result;
}