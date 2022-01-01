library form_view_model;

import 'package:reactive_forms/reactive_forms.dart';

/// A wrapper for the [reactive_forms] package.
///
/// [reactive_forms]: https://pub.dev/packages/reactive_forms
///
/// The intention for this class is to provide an uniform way to build and
/// expose [FormGroup]s. Subclasses will define the form fields as well as the
/// validation logic for each field or for the entire form. Also subclasses
/// need to define how to set the form values from a given model instance and
/// how to build a model instance from a given form state.
///
/// The generic type of this class represents the type of the model backed by
/// the [FormGroup].
abstract class BaseFormViewModel<T> {
  final FormGroup _form;

  /// [FormGroup] exposed through this class.
  FormGroup get form => _form;

  /// Gets the model with the data from the [FormGroup].
  T? get model;

  /// Sets the [FormGroup] value given the model.
  set model(T? model);

  /// Disposes the view model resources, e.g. a value changes subscription on
  /// a [FormControl] field.
  void dispose() => {};

  BaseFormViewModel(this._form);
}
