import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> saveIfUserHasSeenOnboardingScreen(bool status) async {
    await getSharedPreferences().then(
        (sharedPreferences) => sharedPreferences.setBool("onboard", status));
  }

  Future<void> hasUserAddedGoal(bool status) async {
    await getSharedPreferences().then(
        (sharedPreferences) => sharedPreferences.setBool("hasGoal", status));
  }

  Future<bool?> userHasGoalAdded() async {
    return await getSharedPreferences()
        .then((sharedPreferences) => sharedPreferences.getBool("hasGoal"));
  }

  Future<bool?> seenOnboardingScreen() async {
    return await getSharedPreferences()
        .then((sharedPreferences) => sharedPreferences.getBool("onboard"));
  }

  Future<void> loggedIn(bool status) async {
    await getSharedPreferences().then(
        (sharedPreferences) => sharedPreferences.setBool("login", status));
  }

  Future<bool?> isUserLoggedIn() async {
    return await getSharedPreferences()
        .then((sharedPreferences) => sharedPreferences.getBool("login"));
  }

  Future<void> saveList(List boolValues) async {
    List<String> stringList =
        boolValues.map((boolValue) => boolValue ? "1" : "0").toList();
    await getSharedPreferences()
        .then((value) => value.setStringList('boolString', stringList));
  }

  Future boolList() async {
    return await getSharedPreferences()
        .then((value) => value.getStringList('boolString'));
  }

  Future checkUserDetails() async {
    return await getSharedPreferences()
        .then((value) => value.getString('currentUserId'));
  }

  Future saveUserDetails(String uid) async {
    return await getSharedPreferences()
        .then((value) => value.setString('currentUserId', uid));
  }

  Future<bool?> isLessonSelected() async {
    return await getSharedPreferences()
        .then((sharedPreferences) => sharedPreferences.getBool("selected"));
  }

  Future<void> lessonSelected(bool status) async {
    await getSharedPreferences().then(
        (sharedPreferences) => sharedPreferences.setBool("selected", status));
  }
}

class SelectedLessonPrefs {
  final int selectedLessonId;
  final String selectedUserId;

  const SelectedLessonPrefs({required this.selectedLessonId, required this.selectedUserId});
//   // Check if the given lesson ID has already been selected by the given user ID
//    Future<bool> isLessonAlreadySelected(
//       int lessonId, String userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     final selectedLesson = prefs.getInt(selectedLessonId);
//     final selectedUser = prefs.getString(selectedUserId);

//     return selectedLesson == lessonId && selectedUser == userId;
//   }

//   // Save the selected lesson ID and user ID to shared preferences
//   static Future<void> saveSelectedLesson(String lessonId, String userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_selectedLessonKey, lessonId);
//     await prefs.setString(_selectedUserKey, userId);
//   }
 }
