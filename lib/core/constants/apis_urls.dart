/// class [ApisUrls] contains all URLs to external services, services,
/// or APIs, according to the following figure
///
/// add new APIs URL in this way:
/// EX: static const String {verb}featureName = '$_baseApiUrl/{route}';

class ApisUrls {
  /// [_baseUrl] base server url
  static const String _baseUrl = 'https://dummyjson.com';

  /// [_baseApiUrl] base API url
  static const String _baseApiUrl = 'https://dummyjson.com';

  /// [_baseImagesUrl] base Images Url
  static const String _baseImagesUrl = '$_baseUrl/uploads';
  static String baseImagesUrl(String url) => '$_baseImagesUrl/$url';

  /// Auth Feature APIs
  static const String login = '$_baseApiUrl/auth/login';
  static const String register = '$_baseApiUrl/auth/signUp';

  /// get to do list
  static String getToDoList(int limit, int skip) =>
      '$_baseApiUrl/todos?limit=$limit&skip=$skip';

  ///update todo item
  static String updateItem(int id) => '$_baseApiUrl/todos/$id';

  ///delete todo item
  static String deleteItem(int id) => '$_baseApiUrl/todos/$id';
//add item
  static const String addItem = '$_baseApiUrl/todos/add';

}
