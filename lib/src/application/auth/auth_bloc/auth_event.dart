part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authUserChanged({AppUser? user}) = AuthUserChanged;
  const factory AuthEvent.authLogoutRequested() = AuthLogoutRequested;
}
