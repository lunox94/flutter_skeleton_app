import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_skeleton_app/src/application/auth/app_user.dart';
import 'package:flutter_skeleton_app/src/application/auth/auth_facade.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthFacade _authFacade;
  late final StreamSubscription<AppUser?> _userSubscription;

  AuthBloc({required AuthFacade authFacade})
      : _authFacade = authFacade,
        super(authFacade.currentUser != null
            ? AuthState.authenticated(authFacade.currentUser!)
            : AuthState.unauthenticated()) {
    on<AuthUserChanged>(_onUserChanged);
    on<AuthLogoutRequested>(_onLogOutRequested);
    _userSubscription =
        _authFacade.user.listen((user) => add(AuthUserChanged(user: user)));
  }

  void _onLogOutRequested(event, emit) {
    unawaited(_authFacade.logOut());
  }

  void _onUserChanged(event, emit) {
    emit(event.user != null
        ? AuthState.authenticated(_authFacade.currentUser!)
        : AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
