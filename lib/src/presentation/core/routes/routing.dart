import 'package:flutter_skeleton_app/src/application/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_skeleton_app/src/presentation/auth/screens/login.dart';
import 'package:flutter_skeleton_app/src/presentation/core/screens/home.dart';
import 'package:flutter_skeleton_app/src/presentation/core/screens/splash.dart';
import 'package:go_router/go_router.dart';

class Routing {
  late final GoRouter _router;

  static Routing? _instance;

  Routing._(AuthBloc authBloc) {
    _router = _buildRouter(authBloc);
  }

  static Routing instance({required AuthBloc authBloc}) {
    return _instance ??= Routing._(authBloc);
  }

  GoRouter get router => _router;

  GoRouter _buildRouter(AuthBloc authBloc) {
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
