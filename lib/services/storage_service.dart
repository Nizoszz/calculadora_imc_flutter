import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_KEYS{
  KEY_NAME,
  KEY_WEIGHT,
  KEY_HEIGHT
}

class AppStorageService{
  Future<void> setName(String name) async {
    await _setString(STORAGE_KEYS.KEY_NAME.toString(), name);
  }

  Future<String> getName() async {
    return _getString(STORAGE_KEYS.KEY_NAME.toString());
  }

  Future<void> setWeight(double weight) async {
    await _setDouble(STORAGE_KEYS.KEY_WEIGHT.toString(), weight);
  }

  Future<double> getWeight() async {
    return _getDouble(STORAGE_KEYS.KEY_WEIGHT.toString());
  }

  Future<void> setHeight(double height) async {
    await _setDouble(STORAGE_KEYS.KEY_HEIGHT.toString(), height);
  }

  Future<double> getHeight() async {
    return _getDouble(STORAGE_KEYS.KEY_HEIGHT.toString());
  }

  Future<void> _setString(String key, String value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(key, value);
  }

  Future<String> _getString(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(key) ?? "";
  }

  Future<void> _setDouble(String key, double value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setDouble(key, value);
  }

  Future<double> _getDouble(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(key) ?? 0.0;
  }
}