abstract class RegisterState {}

final class RegisterIntialState extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState(this.message);
}

final class RegisterSuccessState extends RegisterState {}

final class RegisterHidePasswordState extends RegisterState {}
