import 'package:bloc/bloc.dart';
import 'package:flutter_skeleton_app/src/application/auth/login_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../auth_facade.dart';

part 'login_form_submission_event.dart';
part 'login_form_submission_state.dart';
part 'login_form_submission_bloc.freezed.dart';

class LoginFormSubmissionBloc
    extends Bloc<LoginFormSubmissionEvent, LoginFormSubmissionState> {
  final AuthFacade _authFacade;

  LoginFormSubmissionBloc({required AuthFacade authFacade})
      : _authFacade = authFacade,
        super(const _Initial()) {
    on<LoginFormSubmissionEvent>((event, emit) async {
      emit(const LoginFormSubmissionState.inProgress());
      try {
        await _authFacade.loginWithEmailAndPassword(event.loginParams);
        emit(const LoginFormSubmissionState.success());
      } catch (e) {
        emit(const LoginFormSubmissionState.failure());
      }
    });
  }
}
