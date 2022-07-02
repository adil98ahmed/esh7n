import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertDialogProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String option = '';

  Future<String?> getPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('defualtOption');
  }

  setDefaultOption(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? defualtOption = prefs.getString('defualtOption');
    if (value != '') {
      if (defualtOption == null) {
        prefs.setString('defualtOption', value);
      }
    }
  }

  Future<void> deletePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  setCurrentOption(String value) {
    option = value;
    notifyListeners();
  }
}
