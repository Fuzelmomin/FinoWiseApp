part of 'treads_bloc.dart';

@immutable
abstract class TreadsEvent {
  const TreadsEvent();
}

class PerformTreadsEvent extends TreadsEvent {
  final dynamic data;

  PerformTreadsEvent({required this.data});
}
