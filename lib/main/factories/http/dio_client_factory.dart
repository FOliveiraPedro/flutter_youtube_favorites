import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../data/http/http.dart';
import '../../../infra/http/http.dart';

HttpClient makeDioAdapter() {
  final Dio client = Dio();
  if (kDebugMode) {
    client.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  return DioAdapter(client: client);
}
