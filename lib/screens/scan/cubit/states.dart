import '../../../Core/error/faliure.dart';

abstract class ScanState {}

final class ScanInitial extends ScanState {}

final class ScanSuccessState extends ScanState {}

final class ScanLoadingState extends ScanState {}

class ScanErrorState extends ScanState {
  Failure failure;

  ScanErrorState(this.failure);
}

final class GetHistorySuccessState extends ScanState {}

final class GetHistoryLoadingState extends ScanState {}

class GetHistoryErrorState extends ScanState {
  Failure failure;

  GetHistoryErrorState(this.failure);
}

final class DeleteHistorySuccessState extends ScanState {}

final class DeleteHistoryLoadingState extends ScanState {}

class DeleteHistoryErrorState extends ScanState {
  Failure failure;

  DeleteHistoryErrorState(this.failure);
}
