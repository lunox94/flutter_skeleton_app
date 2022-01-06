import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';
part 'theme_bloc.g.dart';

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
    return ThemeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toJson();
  }
}
