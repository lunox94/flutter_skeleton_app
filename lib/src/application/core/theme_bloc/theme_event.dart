part of 'theme_bloc.dart';

@freezed
class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.lightModeRequested() = _LightModeRequested;
  const factory ThemeEvent.darkModeRequested() = _DarkModeRequested;
  const factory ThemeEvent.systemModeRequested() = _SystemModeRequested;
}
