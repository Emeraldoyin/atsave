import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
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

  Future<void> saveIfUserHasSeenOnboardingScreen(bool status) async {
    await getSharedPreferences().then(
        (sharedPreferences) => sharedPreferences.setBool("onboard", status));
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

  Future retrieveMessagingToken() async {
    return await getSharedPreferences()
        .then((value) => value.getString('token'));
  }

  Future saveMessagingToken(String token) async {
    return await getSharedPreferences()
        .then((value) => value.setString('token', token));
  }

    Future getUsername() async {
    return await getSharedPreferences()
        .then((value) => value.getString('username'));
  }

  Future saveUsername(String username) async {
    return await getSharedPreferences()
        .then((value) => value.setString('username', username));
  }

}