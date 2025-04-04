import 'package:chat_app_ai/utils/app_constant.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatServices {
  Future<String?> sendPrompt(String prompt) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: AppConstant.apiKey,
    );

    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    await model.startChat();
  }
}
