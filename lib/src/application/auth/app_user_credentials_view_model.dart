import 'package:flutter_skeleton_app/src/application/auth/app_user_credentials.dart';
import 'package:form_view_model/form_view_model.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppUserCredentialsViewModel
    extends BaseFormViewModel<AppUserCredentials> {
  AppUserCredentialsViewModel() : super(_buildForm());

  @override
  AppUserCredentials? get model =>
      form.valid ? AppUserCredentials.fromJson(form.value) : null;

  @override
  set model(AppUserCredentials? model) {
    form.patchValue(model?.toJson());
  }

  static FormGroup _buildForm() {
    return fb.group({
      'email': ['', Validators.required],
      'password': ['', Validators.required]
    });
  }
}
