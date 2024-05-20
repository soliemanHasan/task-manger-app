import 'package:shared_preferences/shared_preferences.dart';

/// [CacheStorageServices] services express services related to storing variables in the cache
/// By defining a [_Keys] variable suitable for the value to be stored, and defining the following 4 methods,
/// you will be able to store any value in memory via these services.
/// 1- [setValue] to store value in cache
///    Future<void> setValue(String value) async => await _preferences?.setString(_Keys.value, value)
/// 2- [removeValue] to remove value from cache
///    Future<void> removeValue() async => await _preferences?.remove(_Keys.value);
/// 3- [value] to get value from cache
///    String? get value => _preferences?.getString(_Keys.value) ?? null;
/// 4- [hasValue] check if this variable stored or not
///    bool get hasValue => _preferences?.containsKey(_Keys.value) ?? false;
///
/// It is important to call [CacheStorageServices.init] in the main.dart file before the [runApp] function
/// await CacheStorageServices.init();

class CacheStorageServices {
  static CacheStorageServices? _instance;
  static SharedPreferences? _preferences;

  CacheStorageServices._();

  factory CacheStorageServices() => _instance ??= CacheStorageServices._();

  // should call init in your main before run app
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // handle store API user token in cache
  Future<void> setToken(String token) async =>
      await _preferences?.setString(_Keys.token, token);

  Future<void> removeToken() async => await _preferences?.remove(_Keys.token);

  bool get hasToken => _preferences?.containsKey(_Keys.token) ?? false;

  String get token => _preferences?.getString(_Keys.token) ?? 'no token';

  // TODO: add your other variables
  // others functions
  /// ...
  Future<void> setId(int id) async =>
      await _preferences?.setInt(_Keys.userId, id);
  int get userId => _preferences?.getInt(_Keys.userId) ?? 5;
}

class _Keys {
  static const String token = 'token';
  static const String userId = 'userId';
}
