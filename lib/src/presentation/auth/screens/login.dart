import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../application/auth/login_form_provider_bloc/login_form_provider_bloc.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginFormProviderBloc(),
      child: Scaffold(
        body: BlocBuilder<LoginFormProviderBloc, LoginFormProviderState>(
          builder: (context, state) {
            return ReactiveForm(
              formGroup: state.viewModel.form,
              child: Column(
                children: [
                  ReactiveTextField(
                    formControlName: 'email',
                  ),
                  ReactiveTextField(
                    formControlName: 'password',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
