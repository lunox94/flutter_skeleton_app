part of 'service_loader_bloc.dart';

@freezed
class ServiceLoaderState with _$ServiceLoaderState {
  const factory ServiceLoaderState.initial() = _Initial;
  const factory ServiceLoaderState.serviceLoadInProgress(
      {required String serviceName}) = _ServiceLoadInProgress;
  const factory ServiceLoaderState.serviceLoadSuccess(
      {required String serviceName}) = _ServiceLoadSuccess;
  //TODO: add Failure field after Failure system is implemented
  const factory ServiceLoaderState.serviceLoadFailure(
      {required String serviceName}) = _ServiceLoadFailure;
  const factory ServiceLoaderState.servicesLoadComplete() =
      _ServicesLoadComplete;
}
