import 'package:flutter_skeleton_app/src/application/auth/login_params.dart';
import 'package:form_view_model/form_view_model.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppUserCredentialsViewModel extends BaseFormViewModel<LoginParams> {
  AppUserCredentialsViewModel() : super(_buildForm());

  @override
  LoginParams? get model =>
      form.valid ? LoginParams.fromJson(form.value) : null;

  @override
  set model(LoginParams? model) {
    form.patchValue(model?.toJson());
  }

  static FormGroup _buildForm() {
    return fb.group({
      'email': ['', Validators.required],
      'password': ['', Validators.required]
    });
  }
}
