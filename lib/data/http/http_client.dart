enum Method {
  post,
  get,
  put,
  patch,
  delete,
}

abstract class HttpClient {
  Future<dynamic> request({
    required final String url,
    required final Method method,
    final Map<String, String> headers = const {},
    final Map<String, dynamic> queryParameters = const {},
    final Map body = const {},
    final List<Map<String, dynamic>> files = const [],
    final bool sendingMultipleFiles = false,
  });
}
