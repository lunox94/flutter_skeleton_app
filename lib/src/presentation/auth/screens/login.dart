import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skeleton_app/src/application/auth/auth_facade.dart';
import 'package:flutter_skeleton_app/src/application/auth/login_form_submission_bloc/login_form_submission_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../application/auth/login_form_provider_bloc/login_form_provider_bloc.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginFormProviderBloc(),
        ),
        BlocProvider(
          create: (context) =>
              LoginFormSubmissionBloc(authFacade: context.read<AuthFacade>()),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<LoginFormProviderBloc, LoginFormProviderState>(
          builder: (context, state) {
            final viewModel = state.viewModel;
            return Center(
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints.expand(
                  height: 450,
                  width: 350,
                ),
                padding: const EdgeInsets.all(10.0),
                child: ReactiveForm(
                  formGroup: viewModel.form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Email'),
                      ReactiveTextField(
                        formControlName: 'email',
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      const Text('Password*'),
                      ReactiveTextField(
                        formControlName: 'password',
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: BlocListener<LoginFormSubmissionBloc,
                                LoginFormSubmissionState>(
                              listener: (context, state) {
                                state.maybeWhen(
                                    inProgress: () =>
                                        viewModel.form.markAsDisabled(),
                                    orElse: () =>
                                        viewModel.form.markAsEnabled());
                              },
                              child: ReactiveFormConsumer(
                                builder: (context, form, _) => ElevatedButton(
                                    onPressed: form.valid
                                        ? () => context
                                            .read<LoginFormSubmissionBloc>()
                                            .add(LoginFormSubmissionEvent
                                                .loginFormSubmissionRequested(
                                                    loginParams:
                                                        viewModel.model!))
                                        : null,
                                    child: const Text('Sign up')),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
