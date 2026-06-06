import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minito/core/utils/audio_utils.dart';
import 'package:minito/features/ai_processing/presentation/providers/processing_provider.dart';
import 'package:minito/features/meetings/presentation/providers/meetings_provider.dart';

// let the user pick an existing audio file from the device and import it
// as a new meeting - identical pipeline as live recording

class UploadScreen extends ConsumerStatefulWidget {
  const UploadScreen({super.key});

  @override
  ConsumerState<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends ConsumerState<UploadScreen> {
  bool _isLoading = false;
  String? _error;

  Future<void> _pickAndUpload() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: AudioUtils.allowedUploadExtensions,
    );

    if (result == null || result.files.isEmpty) {
      setState(() => _isLoading = false);
      return;
    }

    final file = result.files.first;
    if (file.path == null) {
      setState(() {
        _isLoading = false;
        _error = 'Could not access the selected file.';
      });
      return;
    }

    try {
      // 1. save meeting
      final meeting = await ref
          .read(meetingsProvider.notifier)
          .importAudioFile(file.path!, file.name);

      // 2. trigger processing separately
      ref.read(processingProvider.notifier).enqueue(meeting.id);

      if (mounted) context.go('/meeting/${meeting.id}');
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Upload recording')),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.upload_file_rounded,
              size: 80,
              color: theme.colorScheme.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 24),
            Text(
              'Import an audio file',
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Supported formats: ${AudioUtils.allowedUploadExtensions.join(', ')}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            if (_error != null) ...[
              Text(
                _error!,
                style: TextStyle(color: theme.colorScheme.error),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
            ],

            FilledButton(
              onPressed: _isLoading ? null : _pickAndUpload,
              child: _isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.folder_open_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
