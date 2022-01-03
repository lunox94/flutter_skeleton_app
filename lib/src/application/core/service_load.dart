import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_load.freezed.dart';

@freezed
class ServiceLoad with _$ServiceLoad {
  factory ServiceLoad({
    required String serviceName,
    required Future loadJob,
  }) = _ServiceLoad;
}
