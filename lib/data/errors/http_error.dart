import '../../domain/helpers/helpers.dart' show DomainError, ErrorCode;

// TODO(Team): Adicionar o code para vir da API junto com a message e o payload.
class HttpError extends DomainError {
  HttpError.badRequest({final String message = '', final Map<String, dynamic> payload = const {}})
      : super(
          code: ErrorCode.AP400,
          message: message,
          payload: payload,
        );

  HttpError.unauthorized({final String message = '', final Map<String, dynamic> payload = const {}})
      : super(
          code: ErrorCode.AP401,
          message: message,
          payload: payload,
        );

  HttpError.forbidden({final String message = '', final Map<String, dynamic> payload = const {}})
      : super(
          code: ErrorCode.AP403,
          message: message,
          payload: payload,
        );

  HttpError.notFound({final String message = '', final Map<String, dynamic> payload = const {}})
      : super(
          code: ErrorCode.AP404,
          message: message,
          payload: payload,
        );

  HttpError.payloadTooLarge({final String message = '', final Map<String, dynamic> payload = const {}})
      : super(
          code: ErrorCode.AP413,
          message: message,
          payload: payload,
        );

  HttpError.unprocessableEntity({final String message = '', final Map<String, dynamic> payload = const {}})
      : super(
          code: ErrorCode.AP422,
          message: message,
          payload: payload,
        );

  HttpError.serverError({final String message = '', final Map<String, dynamic> payload = const {}})
      : super(
          code: ErrorCode.AP500,
          message: message,
          payload: payload,
        );
}
