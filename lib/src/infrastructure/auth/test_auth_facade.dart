import 'dart:async';

import '../../application/auth/app_user.dart';
import '../../application/auth/auth_facade.dart';
import '../../application/auth/login_params.dart';

class TestAuthFacade implements AuthFacade {
  AppUser? _currentUser;

  final StreamController<AppUser?> _userController;

  @override
  late Stream<AppUser?> user;

  TestAuthFacade() : _userController = StreamController() {
    user = _userController.stream.map((_user) {
      _currentUser = _user;
      return _user;
    }).asBroadcastStream();
    Future.delayed(
        const Duration(seconds: 10), () => _userController.add(null));
  }

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Future<void> logOut() {
    _userController.add(null);
    return Future.value();
  }

  @override
  Future<void> loginWithEmailAndPassword(LoginParams params) {
    _userController.add(AppUser(id: 'userId', email: params.email));
    return Future.delayed(const Duration(milliseconds: 1000));
  }
}
