import 'package:chat_app_ai/utils/app_theme.dart';
import 'package:chat_app_ai/utils/router/app_router.dart';
import 'package:chat_app_ai/utils/router/app_routes.dart';
import 'package:chat_app_ai/view_models/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat With AI',
        theme: AppTheme.themeData,
        initialRoute: AppRoutes.chat,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
