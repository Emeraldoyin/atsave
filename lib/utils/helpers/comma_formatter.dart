String formatDoubleWithComma(double value) {
  String formattedValue = value.toStringAsFixed(2); // Formats with 2 decimal places

  // Adds comma after every 3 digits from the end (before decimal)
  final regEx = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  formattedValue = formattedValue.replaceAllMapped(regEx, (Match match) => '${match[1]},');

  return formattedValue;
}