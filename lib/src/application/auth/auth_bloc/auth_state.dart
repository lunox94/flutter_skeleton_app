part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({required AuthStatus status, AppUser? user}) =
      _AuthState;

  factory AuthState.authenticated(AppUser user) =>
      AuthState(status: AuthStatus.authenticated, user: user);

  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthStatus.unauthenticated);
}
