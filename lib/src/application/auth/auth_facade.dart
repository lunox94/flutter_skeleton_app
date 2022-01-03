import 'package:flutter_skeleton_app/src/application/auth/app_user.dart';
import 'package:flutter_skeleton_app/src/application/auth/login_params.dart';

abstract class AuthFacade {
  late final Stream<AppUser?> user;

  Future<void> loginWithEmailAndPassword(LoginParams params);

  AppUser? get currentUser;

  Future<void> logOut();
}
