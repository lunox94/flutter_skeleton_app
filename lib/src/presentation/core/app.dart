import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../application/auth/auth_bloc/auth_bloc.dart';
import '../../application/auth/auth_facade.dart';
import '../../application/core/theme_bloc/theme_bloc.dart';
import '../../infrastructure/auth/test_auth_facade.dart';
import '../auth/screens/login.dart';
import 'screens/home.dart';
import 'screens/splash.dart';
import 'theme/app_theme.dart';

class Bootstrapper {
  final Widget _app;

  Widget get app => _app;

  Bootstrapper._(Widget app) : _app = app;

  factory Bootstrapper.dev() {
    return Bootstrapper._(
      _App(
        authFacade: TestAuthFacade(),
      ),
    );
  }
}

class _App extends StatelessWidget {
  final AuthBloc _authBloc;

  _App({Key? key, required AuthFacade authFacade})
      : _authBloc = AuthBloc(authFacade: authFacade),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _authBloc,
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

        return MaterialApp.router(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate);
      }),
    );
  }

  late final _router = GoRouter(
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: 'loading',
        path: '/loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const Login(),
      )
    ],
    redirect: (state) {
      // is the user already in the login page?
      final loggingIn = state.subloc == state.namedLocation('login');

      // is the user already in the loading page?
      final loading = state.subloc == state.namedLocation('loading');

      // get the location the user comes from
      final from = state.queryParams['from'] ?? '';

      // get the user's current location
      final current =
          state.subloc != state.namedLocation('home') ? state.subloc : '';

      // build query parameter 'from'
      final fromParam = loggingIn || loading ? from : current;

      final queryParams = {if (fromParam.isNotEmpty) 'from': fromParam};

      // decide which route the user should be redirected to based on the app
      // auth state and the current location, 'null' won't redirect anywhere
      return _authBloc.state.when(
          unknown: () => !loading
              ? state.namedLocation('loading', queryParams: queryParams)
              : null,
          authenticated: (_) => loggingIn || loading
              ? state.queryParams['from'] ?? state.namedLocation('home')
              : null,
          unauthenticated: () => !loggingIn
              ? state.namedLocation('login', queryParams: queryParams)
              : null);
    },
    // changes on the auth state will cause the router to refresh it's route
    refreshListenable: GoRouterRefreshStream(_authBloc.stream),
  );
}
