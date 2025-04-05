import 'package:chat_app_ai/view_models/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatCubit>(context).startChattingSession();
  }

  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Chat With AI'), centerTitle: true),
      body: Center(
        child: TextButton(
          onPressed: () async {
            final prompt = 'Write a story about a magic backpack.';
            await chatCubit.sendMessage(prompt);
          },
          child: const Text('Chat With AI'),
        ),
      ),
    );
  }
}
