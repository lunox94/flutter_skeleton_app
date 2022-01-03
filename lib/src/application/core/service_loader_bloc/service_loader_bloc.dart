import 'package:bloc/bloc.dart';
import 'package:flutter_skeleton_app/src/application/core/service_load.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_loader_event.dart';
part 'service_loader_state.dart';
part 'service_loader_bloc.freezed.dart';

class ServiceLoaderBloc extends Bloc<ServiceLoaderEvent, ServiceLoaderState> {
  ServiceLoaderBloc() : super(const _Initial()) {
    on<_ServicesLoadRequested>((event, emit) async {
      for (var load in event.serviceLoads) {
        emit(ServiceLoaderState.serviceLoadInProgress(
            serviceName: load.serviceName));
        try {
          await load.loadJob;
          emit(ServiceLoaderState.serviceLoadSuccess(
              serviceName: load.serviceName));
        } catch (e) {
          emit(ServiceLoaderState.serviceLoadFailure(
              serviceName: load.serviceName));
        }
      }
      emit(const ServiceLoaderState.servicesLoadComplete());
    });
  }
}
