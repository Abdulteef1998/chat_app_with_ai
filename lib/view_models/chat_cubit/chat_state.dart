part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<MessageModel> messages;

  ChatSuccess(this.messages);
}

class ChatFailure extends ChatState {
  final String error;

  ChatFailure(this.error);
}

class SendingMessage extends ChatState {}

class MessageSent extends ChatState {}

class SendingMessageFailed extends ChatState {
  final String error;

  SendingMessageFailed(this.error);
}
