part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unknown() = _Unknown;

  const factory AuthState.authenticated({required AppUser user}) =
      _Authenticated;

  const factory AuthState.unauthenticated() = _Unauthenticated;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
