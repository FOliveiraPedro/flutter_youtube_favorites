import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../data/errors/errors.dart';
import '../../data/http/http.dart';

class DioAdapter implements HttpClient {
  final Dio client;

  DioAdapter({
    required this.client,
  });

  @override
  Future<dynamic> request({
    required final String url,
    required final Method method,
    final Map<String, String> headers = const {},
    final Map<String, dynamic> queryParameters = const {},
    final Map body = const {},
    final List<Map<String, dynamic>> files = const [],
    final bool sendingMultipleFiles = false,
  }) async {
    Future<Response>? futureResponse;

    Response response = Response(
      data: '',
      requestOptions: RequestOptions(path: url),
      statusCode: 500,
      statusMessage: 'Future response is null',
    );

    final Options options = Options(headers: headers);

    FormData? formData;
    if (files.isNotEmpty) {
      if (files.length == 1 && sendingMultipleFiles == false) {
        formData = FormData.fromMap(
          {
            'file': await MultipartFile.fromFile(
              files[0]['path'] as String,
              filename: '${files[0]['fileName']}.${files[0]['subtype']}',
              contentType: MediaType(files[0]['type'], files[0]['subtype']),
            ),
          }..addAll(Map<String, dynamic>.from(body)),
        );
      } else {
        formData = FormData.fromMap(Map<String, dynamic>.from(body));
        for (final file in files) {
          formData.files.add(
            MapEntry(
              'files',
              await MultipartFile.fromFile(
                file['path'] as String,
                filename: '${file['fileName']}.${file['subtype']}',
                contentType: MediaType(file['type'], file['subtype']),
              ),
            ),
          );
        }
      }
    } else if (sendingMultipleFiles == true) {
      formData = FormData.fromMap(Map<String, dynamic>.from(body));
    }

    try {
      if (method == Method.post) {
        futureResponse = client.post(
          url,
          data: formData ?? body,
          options: options,
          queryParameters: queryParameters,
        );
      } else if (method == Method.get) {
        futureResponse = client.get(
          url,
          options: options,
          queryParameters: queryParameters,
        );
      } else if (method == Method.put) {
        futureResponse = client.put(
          url,
          data: formData ?? body,
          options: options,
          queryParameters: queryParameters,
        );
      } else if (method == Method.patch) {
        futureResponse = client.patch(
          url,
          data: formData ?? body,
          options: options,
          queryParameters: queryParameters,
        );
      } else if (method == Method.delete) {
        futureResponse = client.delete(
          url,
          data: formData ?? body,
          options: options,
          queryParameters: queryParameters,
        );
      }
      if (futureResponse != null) {
        response = await futureResponse.timeout(const Duration(seconds: 15));
      }
    } on DioError catch (error) {
      final Map<String, dynamic> payload =
          error.response != null && error.response?.data != null ? Map.castFrom(error.response?.data) : {};
      if (error.response!.statusCode == 400) {
        throw HttpError.badRequest(message: error.message, payload: payload);
      } else if (error.response!.statusCode == 401) {
        throw HttpError.unauthorized(message: error.message, payload: payload);
      } else if (error.response!.statusCode == 403) {
        throw HttpError.forbidden(message: error.message, payload: payload);
      } else if (error.response!.statusCode == 404) {
        throw HttpError.notFound(message: error.message, payload: payload);
      } else if (error.response!.statusCode == 413) {
        throw HttpError.payloadTooLarge(message: error.message, payload: payload);
      } else if (error.response!.statusCode == 422) {
        throw HttpError.unprocessableEntity(message: error.message, payload: payload);
      } else {
        throw HttpError.serverError();
      }
    }
    return _handleResponse(response);
  }

  dynamic _handleResponse(final Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data ?? {};
    } else if (response.statusCode == 204) {
      return {};
    }
  }
}
