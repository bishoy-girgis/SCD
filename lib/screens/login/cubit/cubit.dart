import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toni/Core/constants/end_points.dart';
import 'package:toni/Core/services/cache_helper.dart';
import 'package:toni/screens/login/cubit/states.dart';

import '../../../Core/error/faliure.dart';

class LoginCubit extends Cubit<LoginState> {
  late final Dio _api;

  LoginCubit(this._api) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void userLogin() async {
    emit(LoginLoadingState());
    try {
      var response = await _api.get(EndPoints.loginToken, queryParameters: {
        'email': userNameController.text,
        'password': passwordController.text,
      });

      if (response.statusCode == 200) {
        SharedPref.set(key: "accessToken", value: response.data['token']);
        print("TOKEN : ${SharedPref.get(key: "accessToken")}");
        emit(LoginSuccessState());
      } else {
        // Handle non-200 status code
        String errorMessage = response.data["error"] ?? "Unknown error occurred";
        emit(LoginErrorState(
          Failure(statusCode: response.statusCode.toString(), message: errorMessage),
        ));
      }
    } on DioError catch (error) {
      // Handle Dio errors (e.g., network issues)
      print(error.toString());
      emit(LoginErrorState(
        Failure(statusCode: '', message: "Error Occurred: ${error.message}"),
      ));
    } catch (error) {
      // Handle generic errors
      print(error.toString());
      emit(LoginErrorState(
        Failure(statusCode: '', message: "Error Occurred: $error"),
      ));
    }
  }
}
