enum UIErrorCode {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  emailInUse,
  addressNotFound,
  addressNotAvailable,
  whatsappError,
  noError,
  phoneNotFounded,
  invalidSmsCode,
  professionalNotAllocated,
  teamWithoutVan,
  alreadyInformedSignage,
}

class UIError {
  final UIErrorCode code;
  final String customMessage;

  UIError({
    required this.code,
    required this.customMessage,
  });

  factory UIError.noError() => UIError(
        code: UIErrorCode.noError,
        customMessage: '',
      );
}

extension DomainErrorExtension on UIError {
  String get description {
    if (code == UIErrorCode.requiredField) {
      return 'required field';
    } else {
      return 'unexpected';
    }
  }
}
