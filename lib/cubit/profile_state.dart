abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetUserDataDone extends ProfileState {}

class GetUserDataLoading extends ProfileState {}

class GetUserDataError extends ProfileState {
  final String error;

  GetUserDataError(this.error);
}
