import 'package:toni/Core/models/UserData.dart';

import '../../../Core/error/faliure.dart';

abstract class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileSuccessState extends ProfileState {
  UserData userData;

  ProfileSuccessState(this.userData);
}
final class ProfileUpdateSuccessState extends ProfileState {
  UserData userData;

  ProfileUpdateSuccessState(this.userData);
}

final class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  Failure failure;

  ProfileErrorState(this.failure);
}
