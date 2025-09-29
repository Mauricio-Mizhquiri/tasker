import 'package:get/get.dart';

class LlmService extends GetConnect {
  final String _apiKey = 'sk...';
  final String _baseUrl = 'https://api.groq.com/openai/v1';
  static const _model = 'llama-3.1-8b-instant';

  LlmService() {
    httpClient.baseUrl = _baseUrl;
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Authorization'] = 'Bearer $_apiKey';
      request.headers['Content-Type'] = 'application/json';
      return request;
    });
  }

  Future<String?> summarize(String text) async {
    final response = await post('/chat/completions', {
      'model': _model,
      'messages': [
        {'role': 'system', 'content': _sysSummary},
        {'role': 'user', 'content': text},
      ],
      'temperature': 0.0,
      'max_tokens': 80,
    });

    if (response.status.hasError) {
      print('Error: ${response.statusCode} - ${response.statusText}');
      print('Body: ${response.bodyString}');
      return null;
    }

    final body = response.body as Map<String, dynamic>;
    final content = body['choices']?[0]?['message']?['content'] as String?;
    return content?.trim();
  }

  static const _sysSummary = '''
Eres un asistente que **responde siempre con máximo 1 frase**, resumiendo el texto del usuario. 
- No repitas frases completas del texto original.
- No agregues información adicional.
- Devuelve únicamente la frase resumida, nada más.
''';
}
