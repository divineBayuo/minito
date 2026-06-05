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

    final formData = FormData.fromMap({
      'model': ApiConstants.whisperModel,
      'file': await MultipartFile.fromFile(
        filePath,
        filename: 'audio.m4a',
        contentType: MediaType('audio', 'm4a'),
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
      throw ServerException(
        message: e.message ?? 'Whisper API error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  // Claude doc generation
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
  }

  // Prompt routing
  String _buildPrompt(String transcript, OutputType type) => switch(type) {
    OutputType.minutes => minutesPrompt(transcript),
    OutputType.notes => notesPrompt(transcript),
    OutputType.report => reportPrompt(transcript),
    OutputType.actionItems => actionItemsPrompt(transcript),
    OutputType.followUpEmail => notesPrompt(transcript), // todo: own prompt
    OutputType.decisionsLog => minutesPrompt(transcript), // todo: own prompt
  };
}
