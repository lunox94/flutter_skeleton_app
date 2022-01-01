import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_credentials.freezed.dart';
part 'app_user_credentials.g.dart';

@freezed
class AppUserCredentials with _$AppUserCredentials {
  factory AppUserCredentials({
    String? email,
    String? password,
  }) = _AppUserCredentials;

  factory AppUserCredentials.fromJson(Map<String, dynamic> json) =>
      _$AppUserCredentialsFromJson(json);
}
