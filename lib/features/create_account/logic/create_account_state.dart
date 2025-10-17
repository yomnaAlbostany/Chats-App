abstract class CreateAccountState {}

final class CreateAccountIntialState extends CreateAccountState {}

final class PickImageState extends CreateAccountState {}

final class CreateAccountLoadingState extends CreateAccountState {}

final class CreateAccountErrorState extends CreateAccountState {
  final String message;

  CreateAccountErrorState(this.message);
}

final class CreateAccountSuccessState extends CreateAccountState {}
