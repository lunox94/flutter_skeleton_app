import 'package:flutter_skeleton_app/src/application/auth/app_user.dart';
import 'package:flutter_skeleton_app/src/application/auth/auth_facade.dart';
import 'package:flutter_skeleton_app/src/application/auth/login_params.dart';

class TestAuthFacade implements AuthFacade {
  @override
  late Stream<AppUser?> user;

  @override
  // TODO: implement currentUser
  AppUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> loginWithEmailAndPassword(LoginParams params) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }
}
