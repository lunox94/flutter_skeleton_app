part of 'login_form_submission_bloc.dart';

@freezed
class LoginFormSubmissionEvent with _$LoginFormSubmissionEvent {
  const factory LoginFormSubmissionEvent.loginFormSubmissionRequested(
      {required LoginParams loginParams}) = _LoginFormSubmissionRequested;
}
