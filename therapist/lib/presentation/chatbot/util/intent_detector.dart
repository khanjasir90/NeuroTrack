import 'package:flutter_gemini/flutter_gemini.dart';

enum ChatIntent {
  schedule,
  general,
}

extension ChatIntentX on ChatIntent {
  bool get isSchedule => this == ChatIntent.schedule;
  bool get isGeneral => this == ChatIntent.general;
}

class IntentDetector {

  static final IntentDetector _instance = IntentDetector._internal();

  IntentDetector._internal();

  static IntentDetector get instance => _instance;

  static const String _intentDetectionPrompt = '''
You are an intent detection system for a medical chatbot called NeuroBot that specializes in autism care.

Analyze the user's message and determine their intent. Respond with ONLY one of these exact options:

- "SCHEDULE" - if the user is asking about appointments, schedule, bookings, calendar, or session times
- "THERAPY_GOALS" - if the user is asking about therapy goals, objectives, or progress targets  
- "REPORTS" - if the user is asking about reports, progress reports, or activity summaries
- "GENERAL" - for any other medical questions, general health inquiries, or autism-related questions

Examples:
- "Show me my schedule" → SCHEDULE
- "When is my next appointment?" → SCHEDULE
- "Book a session" → SCHEDULE
- "What are my therapy goals?" → THERAPY_GOALS
- "Show me my progress report" → REPORTS
- "How can I help my child with autism?" → GENERAL

User message: ''';

  static Future<ChatIntent> detectIntent(String userMessage) async {
    try {
      final response = await Gemini.instance.prompt(
        parts: [Part.text('$_intentDetectionPrompt"$userMessage"')],
      );

      final detectedIntent = response?.output?.trim().toUpperCase();
      
      switch (detectedIntent) {
        case 'SCHEDULE':
          return ChatIntent.schedule;
        case 'GENERAL':
          return ChatIntent.general;
        default:
          return ChatIntent.general;
      }
    } catch (e) {
      return ChatIntent.general;
    }
  }
}