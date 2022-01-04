import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

enum _ThemeMode { light, dark, system }

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const _SystemMode()) {
    on<ThemeEvent>((event, emit) {
      event.when(
        lightModeRequested: () => emit(const ThemeState.lightMode()),
        darkModeRequested: () => emit(const ThemeState.darkMode()),
        systemModeRequested: () => emit(const ThemeState.systemMode()),
      );
    });
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    final idx = json['mode'] as int;
    final mode = _ThemeMode.values[idx];

    switch (mode) {
      case _ThemeMode.light:
        return const ThemeState.lightMode();
      case _ThemeMode.dark:
        return const ThemeState.darkMode();
      case _ThemeMode.system:
        return const ThemeState.systemMode();
      default:
        return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.when(
        lightMode: () => {'mode': _ThemeMode.light.index},
        darkMode: () => {'mode': _ThemeMode.dark.index},
        systemMode: () => {'mode': _ThemeMode.system.index});
  }
}
