import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toni/Core/constants/end_points.dart';
import 'package:toni/Core/models/UserData.dart';
import 'package:toni/screens/profile/cubit/states.dart';
import '../../../Core/error/faliure.dart';

class ProfileCubit extends Cubit<ProfileState> {
  late final Dio _api;

  ProfileCubit(this._api) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserData? user;

  Future<void> getProfileData() async {
    emit(ProfileLoadingState());
    try {
      var response = await _api.get(EndPoints.profileData);

      if (response.statusCode == 200) {
        var userData = UserData.fromJson(response.data);
        user = userData;
        emit(ProfileSuccessState(userData));
      } else {
        emit(ProfileErrorState(
          Failure(
              statusCode: response.statusCode.toString(), message: "$response"),
        ));
      }
    } catch (error) {
      emit(ProfileErrorState(
        Failure(statusCode: '$error', message: error.toString()),
      ));
    }
  }

  updateProfileData({
    required String name,
    required String email,
    required String phone,
    required String birthDate,
    required String gender,
  }) async {
    emit(ProfileLoadingState());
    try {
      var response = await _api.put(EndPoints.profileData, data: {
        "name": name,
        "birthday": birthDate,
        "phone": phone,
        "gender": gender,
        "email": email,
      });

      if (response.statusCode == 200) {
        var userData = UserData.fromJson(response.data);
        user = userData;
        emit(ProfileUpdateSuccessState(userData));
      } else {
        emit(ProfileErrorState(
          Failure(
              statusCode: response.statusCode.toString(), message: "$response"),
        ));
      }
    } catch (error) {
      emit(ProfileErrorState(
        Failure(statusCode: '$error', message: error.toString()),
      ));
    }
  }

  updatePassword({
    required String newPassword,
    required String oldPassword,
  }) async {
    emit(ProfileLoadingState());
    try {
      var response = await _api.put(EndPoints.resetPassword, data: {
        "new_password": newPassword,
        "old_password": oldPassword,
      });

      emit(ProfileChangePasswordSuccessState());
    } on DioException catch (error) {
      emit(ProfileErrorState(
        Failure(
            statusCode: '$error', message: "${error.response?.data["error"]}"),
      ));
    }
  }

  deleteAccount() async {
    emit(ProfileLoadingState());
    try {
      var response = await _api.delete(
        EndPoints.profileData,
      );
      emit(ProfileDeleteSuccessState());
    } catch (error) {
      emit(ProfileErrorState(
        Failure(statusCode: '$error', message: error.toString()),
      ));
    }
  }
}
