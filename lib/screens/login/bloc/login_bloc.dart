import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../api_client/api_constans.dart';
import '../../../api_client/dio_client.dart';
import '../model/login_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<PerformLoginEvent>(_performLogin);
  }
  void _performLogin(PerformLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginState(isLoading: true, isFailed: false));

    DioClient client = DioClient();

    try {
      final response = await client.getDio().post(APIConstants.login, data: event.data);
      final newsResponse = LoginModel.fromJson(response.data);

      emit(LoginState(
          isCompleted: true,
          isLoading: false,
          loginModel: newsResponse
      ));

    } on DioError catch (error) {
      print('MYERRORR $error');
      //return ApiResponse.error(error: ApiUtils.getApiError(error));
      final response = error.response;

      emit(LoginState(
        errorMsg: response!.data['message'],
        isFailed: true,
        isLoading: false,
        isCompleted: false,
      ));

    }

  }
}
