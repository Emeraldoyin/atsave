import 'package:intl/intl.dart';

String formatDateTime(DateTime inputDateTime) {
  // Format the inputDateTime into the desired format
  DateFormat outputFormat = DateFormat("EEEE, MMM d, y");
  String formattedDate = outputFormat.format(inputDateTime);
  return formattedDate;
}