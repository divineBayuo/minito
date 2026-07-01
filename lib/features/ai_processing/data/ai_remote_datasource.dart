// wraps the Whisper transcription API and the Claude messages API
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:minito/core/constants/api_constants.dart';
import 'package:minito/core/errors/exceptions.dart';
import 'package:minito/features/ai_processing/data/prompts/action_items_prompt.dart';
import 'package:minito/features/ai_processing/data/prompts/minutes_prompt.dart';
import 'package:minito/features/ai_processing/data/prompts/notes_prompt.dart';
import 'package:minito/features/ai_processing/data/prompts/report_prompt.dart';
import 'package:minito/features/meetings/domain/models/output_type.dart';

class AiRemoteDatasource {
  AiRemoteDatasource() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(
          milliseconds: ApiConstants.connectTimeoutsMs,
        ),
        receiveTimeout: const Duration(
          milliseconds: ApiConstants.receivedTimeoutsMs,
        ),
      ),
    );
  }

  late final Dio _dio;

  // Whisper transcription
  // uploads filepath to the whisper API and returns the transcript text
  Future<String> transcribeAudio(String filePath) async {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw ServerException(message: 'Audio file not found: $filePath');
    }

    // detect extension and map to correct MIME type
    final ext = filePath.split('.').last.toLowerCase();
    final (filename, contentType) = switch (ext) {
      'mp3' => ('audio.mp3', MediaType('audio', 'mpeg')),
      'mp4' => ('audio.mp4', MediaType('audio', 'mp4')),
      'm4a' => ('audio.m4a', MediaType('audio', 'mp4')),
      'wav' => ('audio.wav', MediaType('audio', 'wav')),
      'webm' => ('audio.webm', MediaType('audio', 'webm')),
      'ogg' => ('audio.ogg', MediaType('audio', 'ogg')),
      'flac' => ('audio.flac', MediaType('audio', 'flac')),
      'aac' => ('audio.aac', MediaType('audio', 'aac')),
      _ => ('audio.m4a', MediaType('audio', 'mp4')),
    };

    // guard: reject obv empty files before hitting API
    final fileSize = await file.length();
    if (fileSize < 1000) {
      throw ServerException(
        message:
            'Audio file is too small (${fileSize}B) - was the microphone permission granted?',
      );
    }

    final formData = FormData.fromMap({
      'model': ApiConstants.whisperModel,
      'file': await MultipartFile.fromFile(
        filePath,
        filename: filename,
        contentType: contentType,
      ),
      'response_format': 'text',
    });

    try {
      final response = await _dio.post(
        ApiConstants.whisperEndpoint,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer ${ApiConstants.openApiKey}'},
        ),
      );
      return response.data as String;
    } on DioException catch (e) {
      // show Whisper's actual error body
      final apiError = e.response?.data is Map
          ? (e.response!.data['error']?['message'] as String?)
          : null;
      throw ServerException(
        message: apiError ?? e.message ?? 'Whisper API error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  /* // Claude doc generation
  Future<String> generateDocument({
    required String transcript,
    required OutputType outputType,
  }) async {
    final prompt = _buildPrompt(transcript, outputType);

    try {
      final response = await _dio.post(
        ApiConstants.claudeMessageEndpoint,
        data: {
          'model': ApiConstants.claudeModel,
          'max_tokens': ApiConstants.claudeMaxTokens,
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
        },
        options: Options(
          headers: {
            'x-api-key': ApiConstants.claudeApiKey,
            'anthropic-version': '2023-06-01',
            'content-type': 'application/json',
          },
        ),
      );

      final content = response.data['content'] as List;
      final textBlock = content.firstWhere(
        (b) => b['type'] == 'text',
        orElse: () =>
            throw const ServerException(message: 'No text in Claude response'),
      );
      return textBlock['text'] as String;
    } on DioException catch (e) {
      throw ServerException(
        message: e.message ?? 'Cluade API error',
        statusCode: e.response?.statusCode,
      );
    }
  } */

  // Gemini doc generation - replacing Claude
  Future<String> generateDocument({
    required String transcript,
    required OutputType outputType,
  }) async {
    final prompt = _buildPrompt(transcript, outputType);
    final url = ApiConstants.geminiEndpoint(ApiConstants.geminiModel);

    try {
      final response = await _dio.post(
        url,
        queryParameters: {'key': ApiConstants.geminiApiKey},
        data: {
          'contents': [
            {
              'role': 'user',
              'parts': {'text': prompt},
            },
          ],
          'generationConfig': {'maxOutputTokens': 4096, 'temperature': 0.4},
        },
        options: Options(headers: {'content-type': 'application/json'}),
      );

      final candidates = response.data['candidates'] as List?;
      if (candidates == null || candidates.isEmpty) {
        throw const ServerException(
          message: 'No candidates in Gemini response',
        );
      }

      final parts = candidates.first['content']?['parts'] as List?;
      final textPart = parts?.firstWhere(
        (p) => p['text'] != null,
        orElse: () =>
            throw const ServerException(message: 'No text in Gemini response'),
      );

      return textPart['text'] as String;
    } on DioException catch (e) {
      // Gemini puts useful error detail here; we want to pull that out
      final apiMessage = e.response?.data?['error']?['message'] as String?;
      throw ServerException(
        message: apiMessage ?? e.message ?? 'Gemini API error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  // Prompt routing
  String _buildPrompt(String transcript, OutputType type) => switch (type) {
    OutputType.minutes => minutesPrompt(transcript),
    OutputType.notes => notesPrompt(transcript),
    OutputType.report => reportPrompt(transcript),
    OutputType.actionItems => actionItemsPrompt(transcript),
    OutputType.followUpEmail => notesPrompt(transcript), // todo: own prompt
    OutputType.decisionsLog => minutesPrompt(transcript), // todo: own prompt
  };
}
