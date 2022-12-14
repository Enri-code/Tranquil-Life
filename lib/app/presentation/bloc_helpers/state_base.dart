import 'package:equatable/equatable.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';

abstract class BlocStateBase extends Equatable {
  const BlocStateBase({this.error, this.status = EventStatus.initial});

  final ApiError? error;
  final EventStatus status;

  BlocStateBase copyWith();

  @override
  List<Object?> get props => [status, error];
}
