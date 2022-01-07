import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/auth_bloc/auth_bloc.dart';
import '../../application/auth/auth_facade.dart';
import '../../application/core/theme_bloc/theme_bloc.dart';
import '../../infrastructure/auth/test_auth_facade.dart';
import 'routes/routing.dart';
import 'theme/app_theme.dart';

Widget onDev() {
  return _App(
    authFacadeBuilder: () => TestAuthFacade(),
  );
}

class _App extends StatelessWidget {
  final AuthFacade Function() _authFacadeBuilder;

  const _App({Key? key, required AuthFacade Function() authFacadeBuilder})
      : _authFacadeBuilder = authFacadeBuilder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => _authFacadeBuilder(),
        )
      ],
      child: Builder(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  AuthBloc(authFacade: context.read<AuthFacade>()),
            ),
            BlocProvider(
              create: (context) => ThemeBloc(),
            ),
          ],
          child: Builder(builder: (context) {
            // rebuilds the app every time the theme mode changes
            final themeMode = context.watch<ThemeBloc>().state.when(
                lightMode: () => ThemeMode.light,
                darkMode: () => ThemeMode.dark,
                systemMode: () => ThemeMode.system);

            final router =
                Routing.instance(authBloc: context.read<AuthBloc>()).router;

            return MaterialApp.router(
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
            );
          }),
        );
      }),
    );
  }
}
