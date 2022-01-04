import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../app_user.dart';
import '../auth_facade.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthFacade _authFacade;
  late final StreamSubscription<AppUser?> _userSubscription;

  AuthBloc({required AuthFacade authFacade})
      : _authFacade = authFacade,
        super(const AuthState.unknown()) {
    on<AuthEvent>((event, emit) {
      event.map(
          userChanged: (event) => _onUserChanged(event, emit),
          logoutRequested: (event) => _onLogOutRequested(event, emit));
    });
    _userSubscription = _authFacade.user
        .listen((user) => add(AuthEvent.userChanged(user: user)));
  }

  void _onLogOutRequested(event, emit) {
    unawaited(_authFacade.logOut());
  }

  void _onUserChanged(event, emit) {
    emit(event.user != null
        ? AuthState.authenticated(user: _authFacade.currentUser!)
        : const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
