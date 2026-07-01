import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:minito/features/meetings/domain/models/output_type.dart';
import 'package:minito/features/meetings/presentation/providers/meetings_provider.dart';
import 'package:path_provider/path_provider.dart';

// ── Theme mode ────────────────────────────────────────────────────────────────

class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _key = 'theme_mode';
  final _storage = const FlutterSecureStorage();

  @override
  ThemeMode build() {
    _load();
    return ThemeMode.system;
  }

  Future<void> _load() async {
    final val = await _storage.read(key: _key);
    state = switch (val) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _storage.write(
      key: _key,
      value: switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      },
    );
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

// ── Default output types ──────────────────────────────────────────────────────

class OutputTypesNotifier extends Notifier<Set<OutputType>> {
  static const _key = 'default_output_types';
  final _storage = const FlutterSecureStorage();

  static const _defaults = {
    OutputType.minutes,
    OutputType.notes,
    OutputType.actionItems,
  };

  @override
  Set<OutputType> build() {
    _load();
    return _defaults;
  }

  Future<void> _load() async {
    final val = await _storage.read(key: _key);
    if (val == null) return;
    final names = val.split(',').where((s) => s.isNotEmpty);
    final types = names
        .map((n) => OutputType.values.where((t) => t.name == n).firstOrNull)
        .whereType<OutputType>()
        .toSet();
    if (types.isNotEmpty) state = types;
  }

  Future<void> toggle(OutputType type) async {
    final next = Set<OutputType>.from(state);
    if (next.contains(type)) {
      // always keep at least one enabled
      if (next.length == 1) return;
      next.remove(type);
    } else {
      next.add(type);
    }
    state = next;
    await _storage.write(key: _key, value: next.map((t) => t.name).join(','));
  }
}

final outputTypesProvider =
    NotifierProvider<OutputTypesNotifier, Set<OutputType>>(
  OutputTypesNotifier.new,
);

// ── Storage stats ─────────────────────────────────────────────────────────────

class StorageStats {
  final int meetingCount;
  final int audioBytes;
  final int dbBytes;

  const StorageStats({
    required this.meetingCount,
    required this.audioBytes,
    required this.dbBytes,
  });

  int get totalBytes => audioBytes + dbBytes;

  String get totalFormatted => _fmt(totalBytes);
  String get audioFormatted => _fmt(audioBytes);
  String get dbFormatted => _fmt(dbBytes);

  String _fmt(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
}

final storageStatsProvider = FutureProvider<StorageStats>((ref) async {
  final meetings = await ref
      .watch(meetingsStreamProvider.future);

  int audioBytes = 0;
  for (final m in meetings) {
    final f = File(m.audioFilePath);
    if (await f.exists()) audioBytes += await f.length();
  }

  // Drift db file size
  int dbBytes = 0;
  try {
    final dir = await getApplicationDocumentsDirectory();
    final db = File('${dir.path}/minito.db');
    if (await db.exists()) dbBytes = await db.length();
  } catch (_) {}

  return StorageStats(
    meetingCount: meetings.length,
    audioBytes: audioBytes,
    dbBytes: dbBytes,
  );
});