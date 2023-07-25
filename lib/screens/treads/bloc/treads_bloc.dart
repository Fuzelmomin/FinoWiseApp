import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fino_wise/screens/treads/model/treads_model.dart';
import 'package:meta/meta.dart';

import '../../../api_client/api_constans.dart';
import '../../../api_client/dio_client.dart';

part 'treads_event.dart';
part 'treads_state.dart';

class TreadsBloc extends Bloc<TreadsEvent, TreadsState> {
  TreadsBloc() : super(TreadsState()) {
    on<PerformTreadsEvent>(_performTreadList);
  }
  void _performTreadList(PerformTreadsEvent event, Emitter<TreadsState> emit) async {
    emit(TreadsState(isLoading: true, isFailed: false));

    DioClient client = DioClient();

    try {
      final response = await client.getDio().post(APIConstants.treadList, data: event.data);
      final newResponse = TreadsModel.fromJson(response.data);

      emit(TreadsState(
          isCompleted: true,
          isLoading: false,
          treadsModel: newResponse
      ));

    } on DioError catch (error) {
      print('MYERRORR $error');
      //return ApiResponse.error(error: ApiUtils.getApiError(error));
      final response = error.response;

      emit(TreadsState(
        errorMsg: response!.data['message'],
        isFailed: true,
        isLoading: false,
        isCompleted: false,
      ));

    }

  }
}
