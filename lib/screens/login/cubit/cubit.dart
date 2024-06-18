import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toni/Core/constants/end_points.dart';
import 'package:toni/Core/error/faliure.dart';
import 'package:toni/Core/services/cache_helper.dart';
import 'package:toni/screens/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginState> {
  late final Dio _api;

  LoginCubit(this._api) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  userLogin() async {
    emit(LoginLoadingState());
    try {
      var response =
          await _api.get(EndPoints.loginToken, queryParameters: {
        'email': userNameController.text,
        'password': passwordController.text,
      });

      if (response.statusCode == 200) {
        SharedPref.set(key: "accessToken", value: response.data['token']);
        print("TOKEN : ${SharedPref.get(key: "accessToken")}");
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState(
          Failure(statusCode: '', message: "$response"),
        ));
      }
    } on DioException catch (error) {
      if (error.response != null && error.response!.statusCode == 500) {
        emit(LoginErrorState(
          Failure(statusCode: '', message: "Internal server error"),
        ));
      } else {
        print(error.toString());
        emit(LoginErrorState(
          Failure(
              statusCode: '',
              message:
                  "There was an unknown error while processing the request."),
        ));
      }
    } catch (error) {
      print(error.toString());
      print("error is ${error.toString()}");
      emit(LoginErrorState(
        Failure(statusCode: '', message: error.toString()),
      ));
    }
  }
}
