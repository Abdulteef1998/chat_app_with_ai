import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:chat_app_ai/services/chat_services.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final chatServices = ChatServices();
  Future<void> sendPrompt(String prompt) async {
    emit(SendingMessage());
    try {
      final response = await chatServices.sendPrompt(prompt);

      emit(ChatSuccess(response));
    } catch (e) {}
    emit(SendingMessageFailed(e.toString()));
  }
}
