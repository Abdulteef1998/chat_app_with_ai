import 'package:chat_app_ai/view_models/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final TextEditingController _messageController;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatCubit>(context).startChattingSession();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Chat With AI'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  bloc: chatCubit,
                  buildWhen: (previous, current) => current is ChatSuccess,
                  builder: (context, state) {
                    if (state is ChatSuccess) {
                      final messages = state.messages;
                      return ListView.builder(
                        itemBuilder: (_, index) {
                          final message = messages[index];
                          return ListTile(
                            title: Text(message.text),
                            subtitle: Text(message.time.toString()),
                            trailing:
                                message.isUser
                                    ? const Icon(Icons.person)
                                    : const Icon(Icons.computer),
                          );
                        },
                        itemCount: messages.length,
                      );
                    } else {
                      return const Center(child: SizedBox.shrink());
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: 'Type a message',
                      ),
                      onSubmitted: (value) {},
                    ),
                  ),
                  const SizedBox(width: 8),
                  BlocConsumer<ChatCubit, ChatState>(
                    bloc: chatCubit,
                    listenWhen:
                        (previous, current) => current is SendingMessageFailed,
                    listener: (context, state) {
                      if (state is SendingMessageFailed) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      if (state is SendingMessage) {
                        return const CircularProgressIndicator.adaptive();
                      }
                      return IconButton(
                        onPressed: () {
                          chatCubit.sendMessage(_messageController.text);
                          _messageController.clear();
                        },
                        icon: Icon(Icons.send),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
