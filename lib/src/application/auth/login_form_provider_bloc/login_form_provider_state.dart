part of 'login_form_provider_bloc.dart';

@freezed
class LoginFormProviderState with _$LoginFormProviderState {
  const factory LoginFormProviderState(
          {required AppUserCredentialsViewModel viewModel}) =
      _LoginFormProviderState;
}
