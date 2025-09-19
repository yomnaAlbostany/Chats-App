abstract class ConversationsState {}

final class ConversationsIntialState extends ConversationsState {}

final class ConversationsChangePageState extends ConversationsState {}

final class ConversationsLoadingState extends ConversationsState {}

final class ConversationsSuccessState extends ConversationsState {}

final class ConversationsErrorState extends ConversationsState {}

final class EditProfileLoadingState extends ConversationsState {}

final class EditProfileSuccessState extends ConversationsState {}

final class EditProfileErrorState extends ConversationsState {
  final String message;

  EditProfileErrorState(this.message);
}
