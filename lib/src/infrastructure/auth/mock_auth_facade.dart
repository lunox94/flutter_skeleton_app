import 'dart:async';

import '../../application/auth/app_user.dart';
import '../../application/auth/auth_facade.dart';
import '../../application/auth/login_params.dart';

class MockAuthFacade implements AuthFacade {
  AppUser? _currentUser;

  final StreamController<AppUser?> _userController;

  @override
  late Stream<AppUser?> user;

  MockAuthFacade() : _userController = StreamController() {
    user = _userController.stream.map((_user) {
      _currentUser = _user;
      return _user;
    }).asBroadcastStream();
    Future.delayed(
        const Duration(seconds: 5),
        // () => _userController.add(AppUser(id: 'id')));
        () => _userController.add(null));
  }

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Future<void> logOut() {
    _userController.add(null);
    return Future.value();
  }

  @override
  Future<void> loginWithEmailAndPassword(LoginParams params) async {
    await Future.delayed(const Duration(seconds: 10));
    _userController.add(AppUser(id: 'userId', email: params.email));
  }
}
