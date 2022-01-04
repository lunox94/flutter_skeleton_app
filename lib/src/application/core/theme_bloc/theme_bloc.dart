import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_event.dart';
part 'theme_state.dart';
part 'theme_bloc.freezed.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const _SystemMode()) {
    on<ThemeEvent>((event, emit) {
      event.when(
        lightModeRequested: () => emit(const ThemeState.lightMode()),
        darkModeRequested: () => emit(const ThemeState.darkMode()),
        systemModeRequested: () => emit(const ThemeState.systemMode()),
      );
    });
  }
}
