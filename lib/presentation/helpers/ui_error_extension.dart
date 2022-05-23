import '../../domain/helpers/helpers.dart';
import '../../ui/helpers/helpers.dart';

extension UIErrorExtension on DomainError {
  UIError get fromDomain => UIError(
        code: UIErrorCode.requiredField,
        customMessage: message.isNotEmpty ? message : '',
      );
}
