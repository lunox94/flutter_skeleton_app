import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/app_user.dart';
import '../auth_facade.dart';

part 'auth_bloc.freezed.dart';
part 'auth_bloc.g.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthFacade _authFacade;
  late final StreamSubscription<AppUser?> _userSubscription;

  AuthBloc({required AuthFacade authFacade})
      : _authFacade = authFacade,
        super(const AuthState.unknown()) {
    on<AuthEvent>((event, emit) {
      event.map(
          userChanged: (event) => _onUserChanged(event, emit),
          logoutRequested: (event) => _onLogOutRequested(event));
    });
    _userSubscription = _authFacade.user
        .listen((user) => add(AuthEvent.userChanged(user: user)));
  }

  void _onLogOutRequested(_LogoutRequested event) {
    unawaited(_authFacade.logOut());
  }

  void _onUserChanged(_UserChanged event, Emitter<AuthState> emit) {
    emit(event.user != null
        ? AuthState.authenticated(user: event.user!)
        : const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
