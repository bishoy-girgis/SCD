import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toni/Core/models/HistoryModel.dart';
import 'package:toni/screens/scan/cubit/states.dart';

import '../../../Core/constants/end_points.dart';
import '../../../Core/error/faliure.dart';

class ScanCubit extends Cubit<ScanState> {
  late final Dio _api;

  ScanCubit(this._api) : super(ScanInitial());

  static ScanCubit get(context) => BlocProvider.of(context);

  HistoryModel? scanResult;
  List<HistoryModel>? allHistory;

  Future<void> getAllHistory() async {
    emit(GetHistoryLoadingState());
    try {
      var response = await _api.get(EndPoints.scan);
      List<dynamic> jsonList = response.data;
      allHistory = HistoryModel.fromJsonList(jsonList);
      emit(GetHistorySuccessState());
    } on DioError catch (error) {
      print(error.toString());
      emit(
        GetHistoryErrorState(
          Failure(
              statusCode: '',
              message: "Error Occurred: ${error.response?.data['error']}"),
        ),
      );
    }
  }

  Future<void> scan({required File image}) async {
    emit(ScanLoadingState());
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image.path, filename: fileName),
      });

      var response = await _api.post(EndPoints.scan, data: formData);
      var userData = HistoryModel.fromJson(response.data);
      scanResult = userData;
      emit(ScanSuccessState());
      getAllHistory();
    } on DioError catch (error) {
      print(error.toString());
      emit(ScanErrorState(
        Failure(
            statusCode: '',
            message: "Error Occurred: ${error.response?.data['error']}"),
      ));
    }
  }

  delete({required String id}) async {
    emit(DeleteHistoryLoadingState());
    try {
      var response = await _api.delete(
        EndPoints.scan,
        data: {
          "id": id,
        },
      );
      getAllHistory();
      emit(DeleteHistorySuccessState());
    } on DioError catch (error) {
      print(error.toString());
      emit(
        DeleteHistoryErrorState(
          Failure(
              statusCode: '',
              message: "Error Occurred: ${error.response?.data['error']}"),
        ),
      );
    }
  }
}
