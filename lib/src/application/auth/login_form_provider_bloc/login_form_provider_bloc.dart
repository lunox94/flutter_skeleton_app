import 'package:bloc/bloc.dart';
import 'package:flutter_skeleton_app/src/application/auth/app_user_credentials_view_model.dart';
import 'package:form_view_model/form_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_form_provider_event.dart';
part 'login_form_provider_state.dart';
part 'login_form_provider_bloc.freezed.dart';

class LoginFormProviderBloc
    extends Bloc<LoginFormProviderEvent, LoginFormProviderState> {
  LoginFormProviderBloc()
      : super(LoginFormProviderState(viewModel: AppUserCredentialsViewModel()));
}
