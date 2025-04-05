import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:chat_app_ai/models/message_model.dart';
import 'package:chat_app_ai/services/chat_services.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final chatServices = ChatServices();
  List<MessageModel> chatMessages = [];
  File? selectedImage;
  Future<void> sendMessage(String message) async {
    emit(SendingMessage());
    try {
      chatMessages.add(
        MessageModel(text: message, isUser: true, time: DateTime.now()),
      );
      // to Update the UI with my new message before message of the AI
      emit(ChatSuccess(chatMessages));
      final response = await chatServices.sendPrompt(message);
      chatMessages.add(
        MessageModel(
          text: response ?? 'No response from AI',
          isUser: false,
          time: DateTime.now(),
        ),
      );
      emit(MessageSent());
      emit(ChatSuccess(chatMessages));
    } catch (e) {}
    emit(SendingMessageFailed(e.toString()));
  }

  void startChattingSession() {
    chatServices.startChattingSession();
  }

  // Future<void> sendMessage(String message) async {
  //   emit(MessageSent());
  //   try {
  //     final response = await chatServices.sendMessage(message);
  //     emit(ChatSuccess(response));
  //   } catch (e) {}
  //   emit(SendingMessageFailed(e.toString()));
  // }
}
