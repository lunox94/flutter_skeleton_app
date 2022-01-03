import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skeleton_app/src/application/auth/auth_facade.dart';
import 'package:go_router/go_router.dart';

import '../../application/auth/auth_bloc/auth_bloc.dart';
import '../auth/screens/login.dart';
import 'screens/splash.dart';

class App extends StatelessWidget {
  final AuthBloc _authBloc;

  App({Key? key, required AuthFacade authFacade})
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
        path: '/splash',
        builder: (context, state) => const Splash(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const Login(),
      )
    ],
    redirect: (state) {},
    refreshListenable: GoRouterRefreshStream(_authBloc.stream),
  );
}
