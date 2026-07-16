import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../../core/constants /api_constants.dart';


class GeminiRemoteDataSource {
  static String apiKey = ApiConstants.geminiApiKey;

  final GenerativeModel _model = GenerativeModel(
    model: "gemini-3.5-flash",
    apiKey: apiKey,
  );

  Future<String> sendMessage(String prompt) async {
    final response = await _model.generateContent(
      [
        Content.text(prompt),
      ],
    );

    return response.text ??
        "Sorry, I couldn't generate a response.";
  }
}