import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../application/auth/auth_bloc/auth_bloc.dart';
import '../../application/auth/auth_facade.dart';
import '../../infrastructure/auth/TestAuthFacade.dart';
import '../auth/screens/login.dart';
import 'screens/splash.dart';

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
        path: '/loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const Login(),
      )
    ],
    redirect: (state) {
      final loggingIn = state.name == 'login';
      return _authBloc.state.when(
          unknown: () => '/loading',
          authenticated: (_) => loggingIn ? '/' : null,
          unauthenticated: () => '/login');
    },
    refreshListenable: GoRouterRefreshStream(_authBloc.stream),
  );
}

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
