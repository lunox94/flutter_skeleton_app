import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../application/auth/auth_bloc/auth_bloc.dart';
import '../../application/auth/auth_facade.dart';
import '../../infrastructure/auth/test_auth_facade.dart';
import '../auth/screens/login.dart';
import 'screens/home.dart';
import 'screens/splash.dart';

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
    return BlocProvider(
      create: (context) => _authBloc,
      child: MaterialApp.router(
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate),
    );
  }

  late final _router = GoRouter(
    routes: [
      GoRoute(
        name: 'home',
        path: '/home',
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
      final loggingIn = state.subloc == '/login';

      // is the user already in the loading page?
      final loading = state.subloc == '/loading';

      // bundle the location the user is comming from into a query parameter
      final fromParam = state.subloc == '/' ? '' : '?from=${state.subloc}';

      // decide which route the user should be redirected to based on the app
      // auth state and the current location, 'null' won't redirect anywhere
      return _authBloc.state.when(
          unknown: () => !loading ? '/loading$fromParam' : null,
          authenticated: (_) => loggingIn || loading
              ? state.queryParams['from'] ?? '/home'
              : null,
          unauthenticated: () => !loggingIn ? '/login$fromParam' : null);
    },
    // changes on the auth state will cause the router to refresh it's route
    refreshListenable: GoRouterRefreshStream(_authBloc.stream),
  );
}
