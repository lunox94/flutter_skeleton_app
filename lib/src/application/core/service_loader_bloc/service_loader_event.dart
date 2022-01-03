part of 'service_loader_bloc.dart';

@freezed
class ServiceLoaderEvent with _$ServiceLoaderEvent {
  const factory ServiceLoaderEvent.servicesLoadRequested(
      {required List<ServiceLoad> serviceLoads}) = _ServicesLoadRequested;
}
