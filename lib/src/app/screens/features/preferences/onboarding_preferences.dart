  import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkIfOnboardingShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingShown') ?? false;
  }