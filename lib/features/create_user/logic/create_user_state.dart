abstract class CreateUserState {}

final class CreateUserIntialState extends CreateUserState {}

final class CreateUserPickImageState extends CreateUserState {}

final class CreateUserLoadingState extends CreateUserState {}

final class CreateUserErrorState extends CreateUserState {
  final String message;

  CreateUserErrorState(this.message);
}

final class CreateUserSuccessState extends CreateUserState {}
