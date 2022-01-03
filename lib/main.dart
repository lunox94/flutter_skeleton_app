import 'package:flutter/material.dart';
import 'package:flutter_skeleton_app/src/infrastructure/auth/TestAuthFacade.dart';

import 'src/presentation/core/app.dart';

void main() {
  runApp(App(
    authFacade: TestAuthFacade(),
  ));
}
