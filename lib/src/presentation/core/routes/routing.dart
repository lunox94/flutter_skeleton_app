import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../application/auth/auth_bloc/auth_bloc.dart';
import '../../auth/screens/login.dart';
import '../screens/home.dart';
import '../screens/splash.dart';

class Routing extends StatefulWidget {
  final Widget Function(BuildContext, GoRouter) _builder;

  const Routing(
      {Key? key, required Widget Function(BuildContext, GoRouter) builder})
      : _builder = builder,
        super(key: key);

  @override
  State<Routing> createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = _initRouter(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(context, _router);
  }

  GoRouter _initRouter(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return GoRouter(
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
        return authBloc.state.when(
          unknown: () => !loading
              ? state.namedLocation('loading', queryParams: queryParams)
              : null,
          authenticated: (_) => loggingIn || loading
              ? state.queryParams['from'] ?? state.namedLocation('home')
              : null,
          unauthenticated: () => !loggingIn
              ? state.namedLocation('login', queryParams: queryParams)
              : null,
        );
      },
      // changes on the auth state will cause the router to refresh it's route
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
    );
  }
}
