import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final String _counterPrefs = "counterValue";
  static final String _timePrefs = "timeValues";

  static Future<double> getCounterValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("GET PREFS");
    return prefs.getDouble(_counterPrefs) ?? 0.0;
  }

  static Future<bool> setCounterValue(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SET PREFS: ${value}");
    return prefs.setDouble(_counterPrefs, value);
  }

  static Future<bool> addTimeValue(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> timeList = prefs.getStringList(_timePrefs) ?? List<String>();
    List<String> newList = [];
    newList = timeList;
    newList.add(value);

    print("ADD TIME: ${value}");
    return prefs.setStringList(_timePrefs, newList);
  }

  static Future<List> getTimeValues() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("SHAREDPREFT - getSavedSettings");
    var timeList = prefs.getStringList(_timePrefs) ?? false;
    //print(timeList.toString());
    return timeList;
  }

  static Future<bool> clearHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("CLEAR PREFS");
    return prefs.setStringList(_timePrefs, []);
  }

  static Future<bool> deleteTime(String deleteTime) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> timeList =
        prefs.getStringList(_timePrefs) ?? List<String>();
    List<String> newList = [];

    for (var time in timeList) {
      if (!time.contains(deleteTime)) {
        newList.add(time);
      }
    }
    print("DELETE TIME PREFS");
    return prefs.setStringList(_timePrefs, newList);









  }
}
