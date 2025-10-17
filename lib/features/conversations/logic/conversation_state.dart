abstract class ConversationState {}

final class ConversationIntialState extends ConversationState {}

final class ChangePagesState extends ConversationState {}

final class ConversationLoadingState extends ConversationState {}

final class ConversationErrorState extends ConversationState {
  final String message;

  ConversationErrorState(this.message);
}

final class ConversationSuccessState extends ConversationState {}

final class UserLoadingState extends ConversationState {}

final class UserErrorState extends ConversationState {}

final class UserSuccessState extends ConversationState {}

final class UpdateProfileLoadingState extends ConversationState {}

final class UpdateProfileSuccesState extends ConversationState {}

final class PickImageState extends ConversationState{}
