// Function to calculate the number of days left to reach the goalCompletionDate
int calculateDaysLeft(DateTime goalCompletionDate) {
  DateTime now = DateTime.now();
  Duration difference = goalCompletionDate.difference(now);
  int daysLeft = difference.inDays;
  return daysLeft;
}