import 'package:intl/intl.dart';

String formatDateTime(DateTime inputDateTime) {
  // Format the inputDateTime into the desired format
  DateFormat outputFormat = DateFormat("EEEE, MMM d, y");
  String formattedDate = outputFormat.format(inputDateTime);
  return formattedDate;
}

String formatDateTimeToDayMonth(DateTime dateTime) {
  // Create a date format pattern for day and month
  final dateFormat = DateFormat('dd/MM');
  
  // Format the DateTime object using the specified pattern
  return dateFormat.format(dateTime);
}