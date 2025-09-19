abstract class MessagesState {}

final class MessagesIntialState extends MessagesState {}

final class SendMessageLoadingState extends MessagesState {}

final class SendMessageErrorState extends MessagesState {
  final String message;

  SendMessageErrorState(this.message);
}

final class SendMessageSuccessState extends MessagesState {}

final class MessageLoadingState extends MessagesState {}

final class MessageErrorState extends MessagesState {
  final String message;

  MessageErrorState(this.message);
}

final class MessageSuccessState extends MessagesState {}

final class MessageUpdateState extends MessagesState {
  final bool status;

  MessageUpdateState(this.status);

}
