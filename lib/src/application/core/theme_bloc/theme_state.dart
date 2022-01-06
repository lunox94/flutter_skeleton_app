part of 'theme_bloc.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState.lightMode() = _LightMode;
  const factory ThemeState.darkMode() = _DarkMode;
  const factory ThemeState.systemMode() = _SystemMode;

  factory ThemeState.fromJson(Map<String, dynamic> json) =>
      _$ThemeStateFromJson(json);
}
