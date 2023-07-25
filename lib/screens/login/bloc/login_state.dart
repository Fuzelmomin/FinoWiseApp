part of 'login_bloc.dart';

class LoginState {

  final bool isLoading;
  final String? errorMsg;
  final bool isCompleted;
  final bool isEmailVerified;
  final bool isFailed;
  final LoginModel? loginModel;

  LoginState({
    this.isLoading = false,
    this.errorMsg = '',
    this.isCompleted = false,
    this.isFailed = false,
    this.isEmailVerified = false,
    this.loginModel
  });
}
