// home for every external api url and key name
abstract class ApiConstants {
  // -- anthropic/claude
  static const claudeBaseUrl = 'https://api.anthropic.com/v1';
  static const claudeMessageEndpoint = '$claudeBaseUrl/messages';
  static const claudeModel = 'claude-sonnet-4-20260527';
  static const claudeMaxTokens = 4096;

  // -- openAI whisper
  static const whisperBaseUrl = 'https://api.openai.com/v1';
  static const whisperEndpoint = '$whisperBaseUrl/audio/transcriptions';
  static const whisperModel = 'whisper-1';

  // -- firebase
  static const firebaseAudioBucket = 'audio-recordings';
  static const claudeApiKey = String.fromEnvironment('CLAUDE_API_kEY');
  static const openApiKey = String.fromEnvironment('OPENAI_API_KEY');

  // Timeouts
  static const connectTimeoutsMs = 30000;
  static const receivedTimeoutsMs = 120000;
  // AI calls can be slow sometimes
}
