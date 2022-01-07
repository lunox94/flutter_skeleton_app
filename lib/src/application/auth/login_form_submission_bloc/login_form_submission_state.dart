part of 'login_form_submission_bloc.dart';

@freezed
class LoginFormSubmissionState with _$LoginFormSubmissionState {
  const factory LoginFormSubmissionState.initial() = _Initial;
  const factory LoginFormSubmissionState.inProgress() = _InProgress;
  const factory LoginFormSubmissionState.success() = _Success;
  const factory LoginFormSubmissionState.failure() = _Failure;
}
