import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_form_submission_event.dart';
part 'login_form_submission_state.dart';
part 'login_form_submission_bloc.freezed.dart';

class LoginFormSubmissionBloc extends Bloc<LoginFormSubmissionEvent, LoginFormSubmissionState> {
  LoginFormSubmissionBloc() : super(_Initial()) {
    on<LoginFormSubmissionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
