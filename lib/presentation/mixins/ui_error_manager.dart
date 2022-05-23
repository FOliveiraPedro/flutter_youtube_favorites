import 'package:get/state_manager.dart';

import '../../ui/helpers/helpers.dart';
mixin UIErrorManager {
  final Rx<UIError> _dialogError = Rx<UIError>(UIError.noError());
  Stream<UIError> get dialogErrorStream => _dialogError.stream;
  set dialogError(final UIError value) => _dialogError.value = value;

  final Rx<UIError> _snackbarError = Rx<UIError>(UIError.noError());
  Stream<UIError> get snackbarErrorStream => _snackbarError.stream;
  set snackbarError(final UIError value) => _dialogError.value = value;
}
