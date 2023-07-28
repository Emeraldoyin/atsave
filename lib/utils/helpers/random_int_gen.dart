import 'dart:math';

int generateRandomNo() {
  Random random = Random();
  int randomNumber =
      random.nextInt(3); // generates a random integer between 0 and 99
  return randomNumber;
}
