abstract class ApiConsumer {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});

  Future<dynamic> post(String path,
      {Map<String, dynamic>? data,
      bool isFormData,
      Map<String, dynamic>? queryParameters});

  Future<dynamic> put(String path,
      {Map<String, dynamic>? data,
      bool isFormData,
      Map<String, dynamic>? queryParameters});

  Future<dynamic> delete(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters});
}
