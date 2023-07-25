part of 'treads_bloc.dart';


class TreadsState {

  final bool isLoading;
  final String? errorMsg;
  final bool isCompleted;
  final bool isEmailVerified;
  final bool isFailed;
  final TreadsModel? treadsModel;

  TreadsState({
    this.isLoading = false,
    this.errorMsg = '',
    this.isCompleted = false,
    this.isFailed = false,
    this.isEmailVerified = false,
    this.treadsModel
  });
}
