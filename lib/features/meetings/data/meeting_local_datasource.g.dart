// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_local_datasource.dart';

// ignore_for_file: type=lint
class $MeetingEntriesTable extends MeetingEntries
    with TableInfo<$MeetingEntriesTable, MeetingEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeetingEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioFilePathMeta = const VerificationMeta(
    'audioFilePath',
  );
  @override
  late final GeneratedColumn<String> audioFilePath = GeneratedColumn<String>(
    'audio_file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    createdAt,
    audioFilePath,
    durationSeconds,
    status,
    errorMessage,
    tags,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meeting_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<MeetingEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('audio_file_path')) {
      context.handle(
        _audioFilePathMeta,
        audioFilePath.isAcceptableOrUnknown(
          data['audio_file_path']!,
          _audioFilePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_audioFilePathMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MeetingEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeetingEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      audioFilePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_file_path'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
    );
  }

  @override
  $MeetingEntriesTable createAlias(String alias) {
    return $MeetingEntriesTable(attachedDatabase, alias);
  }
}

class MeetingEntry extends DataClass implements Insertable<MeetingEntry> {
  final String id;
  final String title;
  final DateTime createdAt;
  final String audioFilePath;
  final int durationSeconds;
  final String status;
  final String? errorMessage;
  final String tags;
  const MeetingEntry({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.audioFilePath,
    required this.durationSeconds,
    required this.status,
    this.errorMessage,
    required this.tags,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['audio_file_path'] = Variable<String>(audioFilePath);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['tags'] = Variable<String>(tags);
    return map;
  }

  MeetingEntriesCompanion toCompanion(bool nullToAbsent) {
    return MeetingEntriesCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
      audioFilePath: Value(audioFilePath),
      durationSeconds: Value(durationSeconds),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      tags: Value(tags),
    );
  }

  factory MeetingEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeetingEntry(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      audioFilePath: serializer.fromJson<String>(json['audioFilePath']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'audioFilePath': serializer.toJson<String>(audioFilePath),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'tags': serializer.toJson<String>(tags),
    };
  }

  MeetingEntry copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    String? audioFilePath,
    int? durationSeconds,
    String? status,
    Value<String?> errorMessage = const Value.absent(),
    String? tags,
  }) => MeetingEntry(
    id: id ?? this.id,
    title: title ?? this.title,
    createdAt: createdAt ?? this.createdAt,
    audioFilePath: audioFilePath ?? this.audioFilePath,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    status: status ?? this.status,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    tags: tags ?? this.tags,
  );
  MeetingEntry copyWithCompanion(MeetingEntriesCompanion data) {
    return MeetingEntry(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      audioFilePath: data.audioFilePath.present
          ? data.audioFilePath.value
          : this.audioFilePath,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeetingEntry(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('audioFilePath: $audioFilePath, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    createdAt,
    audioFilePath,
    durationSeconds,
    status,
    errorMessage,
    tags,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeetingEntry &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.audioFilePath == this.audioFilePath &&
          other.durationSeconds == this.durationSeconds &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage &&
          other.tags == this.tags);
}

class MeetingEntriesCompanion extends UpdateCompanion<MeetingEntry> {
  final Value<String> id;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<String> audioFilePath;
  final Value<int> durationSeconds;
  final Value<String> status;
  final Value<String?> errorMessage;
  final Value<String> tags;
  final Value<int> rowid;
  const MeetingEntriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.audioFilePath = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.tags = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MeetingEntriesCompanion.insert({
    required String id,
    required String title,
    required DateTime createdAt,
    required String audioFilePath,
    required int durationSeconds,
    required String status,
    this.errorMessage = const Value.absent(),
    this.tags = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       createdAt = Value(createdAt),
       audioFilePath = Value(audioFilePath),
       durationSeconds = Value(durationSeconds),
       status = Value(status);
  static Insertable<MeetingEntry> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<String>? audioFilePath,
    Expression<int>? durationSeconds,
    Expression<String>? status,
    Expression<String>? errorMessage,
    Expression<String>? tags,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (audioFilePath != null) 'audio_file_path': audioFilePath,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
      if (tags != null) 'tags': tags,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MeetingEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<DateTime>? createdAt,
    Value<String>? audioFilePath,
    Value<int>? durationSeconds,
    Value<String>? status,
    Value<String?>? errorMessage,
    Value<String>? tags,
    Value<int>? rowid,
  }) {
    return MeetingEntriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      audioFilePath: audioFilePath ?? this.audioFilePath,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      tags: tags ?? this.tags,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (audioFilePath.present) {
      map['audio_file_path'] = Variable<String>(audioFilePath.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeetingEntriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('audioFilePath: $audioFilePath, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('tags: $tags, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TranscriptEntriesTable extends TranscriptEntries
    with TableInfo<$TranscriptEntriesTable, TranscriptEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TranscriptEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meetingIdMeta = const VerificationMeta(
    'meetingId',
  );
  @override
  late final GeneratedColumn<String> meetingId = GeneratedColumn<String>(
    'meeting_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullTextMeta = const VerificationMeta(
    'fullText',
  );
  @override
  late final GeneratedColumn<String> fullText = GeneratedColumn<String>(
    'full_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _segmentsJsonMeta = const VerificationMeta(
    'segmentsJson',
  );
  @override
  late final GeneratedColumn<String> segmentsJson = GeneratedColumn<String>(
    'segments_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    meetingId,
    fullText,
    languageCode,
    segmentsJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transcript_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TranscriptEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('meeting_id')) {
      context.handle(
        _meetingIdMeta,
        meetingId.isAcceptableOrUnknown(data['meeting_id']!, _meetingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_meetingIdMeta);
    }
    if (data.containsKey('full_text')) {
      context.handle(
        _fullTextMeta,
        fullText.isAcceptableOrUnknown(data['full_text']!, _fullTextMeta),
      );
    } else if (isInserting) {
      context.missing(_fullTextMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('segments_json')) {
      context.handle(
        _segmentsJsonMeta,
        segmentsJson.isAcceptableOrUnknown(
          data['segments_json']!,
          _segmentsJsonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TranscriptEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TranscriptEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      meetingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meeting_id'],
      )!,
      fullText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_text'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      segmentsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}segments_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TranscriptEntriesTable createAlias(String alias) {
    return $TranscriptEntriesTable(attachedDatabase, alias);
  }
}

class TranscriptEntry extends DataClass implements Insertable<TranscriptEntry> {
  final String id;
  final String meetingId;
  final String fullText;
  final String languageCode;
  final String segmentsJson;
  final DateTime createdAt;
  const TranscriptEntry({
    required this.id,
    required this.meetingId,
    required this.fullText,
    required this.languageCode,
    required this.segmentsJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['meeting_id'] = Variable<String>(meetingId);
    map['full_text'] = Variable<String>(fullText);
    map['language_code'] = Variable<String>(languageCode);
    map['segments_json'] = Variable<String>(segmentsJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TranscriptEntriesCompanion toCompanion(bool nullToAbsent) {
    return TranscriptEntriesCompanion(
      id: Value(id),
      meetingId: Value(meetingId),
      fullText: Value(fullText),
      languageCode: Value(languageCode),
      segmentsJson: Value(segmentsJson),
      createdAt: Value(createdAt),
    );
  }

  factory TranscriptEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TranscriptEntry(
      id: serializer.fromJson<String>(json['id']),
      meetingId: serializer.fromJson<String>(json['meetingId']),
      fullText: serializer.fromJson<String>(json['fullText']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      segmentsJson: serializer.fromJson<String>(json['segmentsJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'meetingId': serializer.toJson<String>(meetingId),
      'fullText': serializer.toJson<String>(fullText),
      'languageCode': serializer.toJson<String>(languageCode),
      'segmentsJson': serializer.toJson<String>(segmentsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TranscriptEntry copyWith({
    String? id,
    String? meetingId,
    String? fullText,
    String? languageCode,
    String? segmentsJson,
    DateTime? createdAt,
  }) => TranscriptEntry(
    id: id ?? this.id,
    meetingId: meetingId ?? this.meetingId,
    fullText: fullText ?? this.fullText,
    languageCode: languageCode ?? this.languageCode,
    segmentsJson: segmentsJson ?? this.segmentsJson,
    createdAt: createdAt ?? this.createdAt,
  );
  TranscriptEntry copyWithCompanion(TranscriptEntriesCompanion data) {
    return TranscriptEntry(
      id: data.id.present ? data.id.value : this.id,
      meetingId: data.meetingId.present ? data.meetingId.value : this.meetingId,
      fullText: data.fullText.present ? data.fullText.value : this.fullText,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      segmentsJson: data.segmentsJson.present
          ? data.segmentsJson.value
          : this.segmentsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TranscriptEntry(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('fullText: $fullText, ')
          ..write('languageCode: $languageCode, ')
          ..write('segmentsJson: $segmentsJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    meetingId,
    fullText,
    languageCode,
    segmentsJson,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TranscriptEntry &&
          other.id == this.id &&
          other.meetingId == this.meetingId &&
          other.fullText == this.fullText &&
          other.languageCode == this.languageCode &&
          other.segmentsJson == this.segmentsJson &&
          other.createdAt == this.createdAt);
}

class TranscriptEntriesCompanion extends UpdateCompanion<TranscriptEntry> {
  final Value<String> id;
  final Value<String> meetingId;
  final Value<String> fullText;
  final Value<String> languageCode;
  final Value<String> segmentsJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TranscriptEntriesCompanion({
    this.id = const Value.absent(),
    this.meetingId = const Value.absent(),
    this.fullText = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.segmentsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TranscriptEntriesCompanion.insert({
    required String id,
    required String meetingId,
    required String fullText,
    required String languageCode,
    this.segmentsJson = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       meetingId = Value(meetingId),
       fullText = Value(fullText),
       languageCode = Value(languageCode),
       createdAt = Value(createdAt);
  static Insertable<TranscriptEntry> custom({
    Expression<String>? id,
    Expression<String>? meetingId,
    Expression<String>? fullText,
    Expression<String>? languageCode,
    Expression<String>? segmentsJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (meetingId != null) 'meeting_id': meetingId,
      if (fullText != null) 'full_text': fullText,
      if (languageCode != null) 'language_code': languageCode,
      if (segmentsJson != null) 'segments_json': segmentsJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TranscriptEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? meetingId,
    Value<String>? fullText,
    Value<String>? languageCode,
    Value<String>? segmentsJson,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TranscriptEntriesCompanion(
      id: id ?? this.id,
      meetingId: meetingId ?? this.meetingId,
      fullText: fullText ?? this.fullText,
      languageCode: languageCode ?? this.languageCode,
      segmentsJson: segmentsJson ?? this.segmentsJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (meetingId.present) {
      map['meeting_id'] = Variable<String>(meetingId.value);
    }
    if (fullText.present) {
      map['full_text'] = Variable<String>(fullText.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (segmentsJson.present) {
      map['segments_json'] = Variable<String>(segmentsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TranscriptEntriesCompanion(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('fullText: $fullText, ')
          ..write('languageCode: $languageCode, ')
          ..write('segmentsJson: $segmentsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MeetingOutputEntriesTable extends MeetingOutputEntries
    with TableInfo<$MeetingOutputEntriesTable, MeetingOutputEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeetingOutputEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meetingIdMeta = const VerificationMeta(
    'meetingId',
  );
  @override
  late final GeneratedColumn<String> meetingId = GeneratedColumn<String>(
    'meeting_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _markdownContentMeta = const VerificationMeta(
    'markdownContent',
  );
  @override
  late final GeneratedColumn<String> markdownContent = GeneratedColumn<String>(
    'markdown_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelVersionMeta = const VerificationMeta(
    'modelVersion',
  );
  @override
  late final GeneratedColumn<String> modelVersion = GeneratedColumn<String>(
    'model_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    meetingId,
    type,
    markdownContent,
    generatedAt,
    modelVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meeting_output_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<MeetingOutputEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('meeting_id')) {
      context.handle(
        _meetingIdMeta,
        meetingId.isAcceptableOrUnknown(data['meeting_id']!, _meetingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_meetingIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('markdown_content')) {
      context.handle(
        _markdownContentMeta,
        markdownContent.isAcceptableOrUnknown(
          data['markdown_content']!,
          _markdownContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_markdownContentMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    if (data.containsKey('model_version')) {
      context.handle(
        _modelVersionMeta,
        modelVersion.isAcceptableOrUnknown(
          data['model_version']!,
          _modelVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_modelVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MeetingOutputEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeetingOutputEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      meetingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meeting_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      markdownContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}markdown_content'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
      modelVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_version'],
      )!,
    );
  }

  @override
  $MeetingOutputEntriesTable createAlias(String alias) {
    return $MeetingOutputEntriesTable(attachedDatabase, alias);
  }
}

class MeetingOutputEntry extends DataClass
    implements Insertable<MeetingOutputEntry> {
  final String id;
  final String meetingId;
  final String type;
  final String markdownContent;
  final DateTime generatedAt;
  final String modelVersion;
  const MeetingOutputEntry({
    required this.id,
    required this.meetingId,
    required this.type,
    required this.markdownContent,
    required this.generatedAt,
    required this.modelVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['meeting_id'] = Variable<String>(meetingId);
    map['type'] = Variable<String>(type);
    map['markdown_content'] = Variable<String>(markdownContent);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    map['model_version'] = Variable<String>(modelVersion);
    return map;
  }

  MeetingOutputEntriesCompanion toCompanion(bool nullToAbsent) {
    return MeetingOutputEntriesCompanion(
      id: Value(id),
      meetingId: Value(meetingId),
      type: Value(type),
      markdownContent: Value(markdownContent),
      generatedAt: Value(generatedAt),
      modelVersion: Value(modelVersion),
    );
  }

  factory MeetingOutputEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeetingOutputEntry(
      id: serializer.fromJson<String>(json['id']),
      meetingId: serializer.fromJson<String>(json['meetingId']),
      type: serializer.fromJson<String>(json['type']),
      markdownContent: serializer.fromJson<String>(json['markdownContent']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
      modelVersion: serializer.fromJson<String>(json['modelVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'meetingId': serializer.toJson<String>(meetingId),
      'type': serializer.toJson<String>(type),
      'markdownContent': serializer.toJson<String>(markdownContent),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
      'modelVersion': serializer.toJson<String>(modelVersion),
    };
  }

  MeetingOutputEntry copyWith({
    String? id,
    String? meetingId,
    String? type,
    String? markdownContent,
    DateTime? generatedAt,
    String? modelVersion,
  }) => MeetingOutputEntry(
    id: id ?? this.id,
    meetingId: meetingId ?? this.meetingId,
    type: type ?? this.type,
    markdownContent: markdownContent ?? this.markdownContent,
    generatedAt: generatedAt ?? this.generatedAt,
    modelVersion: modelVersion ?? this.modelVersion,
  );
  MeetingOutputEntry copyWithCompanion(MeetingOutputEntriesCompanion data) {
    return MeetingOutputEntry(
      id: data.id.present ? data.id.value : this.id,
      meetingId: data.meetingId.present ? data.meetingId.value : this.meetingId,
      type: data.type.present ? data.type.value : this.type,
      markdownContent: data.markdownContent.present
          ? data.markdownContent.value
          : this.markdownContent,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
      modelVersion: data.modelVersion.present
          ? data.modelVersion.value
          : this.modelVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeetingOutputEntry(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('type: $type, ')
          ..write('markdownContent: $markdownContent, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('modelVersion: $modelVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    meetingId,
    type,
    markdownContent,
    generatedAt,
    modelVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeetingOutputEntry &&
          other.id == this.id &&
          other.meetingId == this.meetingId &&
          other.type == this.type &&
          other.markdownContent == this.markdownContent &&
          other.generatedAt == this.generatedAt &&
          other.modelVersion == this.modelVersion);
}

class MeetingOutputEntriesCompanion
    extends UpdateCompanion<MeetingOutputEntry> {
  final Value<String> id;
  final Value<String> meetingId;
  final Value<String> type;
  final Value<String> markdownContent;
  final Value<DateTime> generatedAt;
  final Value<String> modelVersion;
  final Value<int> rowid;
  const MeetingOutputEntriesCompanion({
    this.id = const Value.absent(),
    this.meetingId = const Value.absent(),
    this.type = const Value.absent(),
    this.markdownContent = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.modelVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MeetingOutputEntriesCompanion.insert({
    required String id,
    required String meetingId,
    required String type,
    required String markdownContent,
    required DateTime generatedAt,
    required String modelVersion,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       meetingId = Value(meetingId),
       type = Value(type),
       markdownContent = Value(markdownContent),
       generatedAt = Value(generatedAt),
       modelVersion = Value(modelVersion);
  static Insertable<MeetingOutputEntry> custom({
    Expression<String>? id,
    Expression<String>? meetingId,
    Expression<String>? type,
    Expression<String>? markdownContent,
    Expression<DateTime>? generatedAt,
    Expression<String>? modelVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (meetingId != null) 'meeting_id': meetingId,
      if (type != null) 'type': type,
      if (markdownContent != null) 'markdown_content': markdownContent,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (modelVersion != null) 'model_version': modelVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MeetingOutputEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? meetingId,
    Value<String>? type,
    Value<String>? markdownContent,
    Value<DateTime>? generatedAt,
    Value<String>? modelVersion,
    Value<int>? rowid,
  }) {
    return MeetingOutputEntriesCompanion(
      id: id ?? this.id,
      meetingId: meetingId ?? this.meetingId,
      type: type ?? this.type,
      markdownContent: markdownContent ?? this.markdownContent,
      generatedAt: generatedAt ?? this.generatedAt,
      modelVersion: modelVersion ?? this.modelVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (meetingId.present) {
      map['meeting_id'] = Variable<String>(meetingId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (markdownContent.present) {
      map['markdown_content'] = Variable<String>(markdownContent.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (modelVersion.present) {
      map['model_version'] = Variable<String>(modelVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeetingOutputEntriesCompanion(')
          ..write('id: $id, ')
          ..write('meetingId: $meetingId, ')
          ..write('type: $type, ')
          ..write('markdownContent: $markdownContent, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MeetingEntriesTable meetingEntries = $MeetingEntriesTable(this);
  late final $TranscriptEntriesTable transcriptEntries =
      $TranscriptEntriesTable(this);
  late final $MeetingOutputEntriesTable meetingOutputEntries =
      $MeetingOutputEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    meetingEntries,
    transcriptEntries,
    meetingOutputEntries,
  ];
}

typedef $$MeetingEntriesTableCreateCompanionBuilder =
    MeetingEntriesCompanion Function({
      required String id,
      required String title,
      required DateTime createdAt,
      required String audioFilePath,
      required int durationSeconds,
      required String status,
      Value<String?> errorMessage,
      Value<String> tags,
      Value<int> rowid,
    });
typedef $$MeetingEntriesTableUpdateCompanionBuilder =
    MeetingEntriesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<DateTime> createdAt,
      Value<String> audioFilePath,
      Value<int> durationSeconds,
      Value<String> status,
      Value<String?> errorMessage,
      Value<String> tags,
      Value<int> rowid,
    });

class $$MeetingEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $MeetingEntriesTable> {
  $$MeetingEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioFilePath => $composableBuilder(
    column: $table.audioFilePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MeetingEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MeetingEntriesTable> {
  $$MeetingEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioFilePath => $composableBuilder(
    column: $table.audioFilePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MeetingEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeetingEntriesTable> {
  $$MeetingEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get audioFilePath => $composableBuilder(
    column: $table.audioFilePath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);
}

class $$MeetingEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeetingEntriesTable,
          MeetingEntry,
          $$MeetingEntriesTableFilterComposer,
          $$MeetingEntriesTableOrderingComposer,
          $$MeetingEntriesTableAnnotationComposer,
          $$MeetingEntriesTableCreateCompanionBuilder,
          $$MeetingEntriesTableUpdateCompanionBuilder,
          (
            MeetingEntry,
            BaseReferences<_$AppDatabase, $MeetingEntriesTable, MeetingEntry>,
          ),
          MeetingEntry,
          PrefetchHooks Function()
        > {
  $$MeetingEntriesTableTableManager(
    _$AppDatabase db,
    $MeetingEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeetingEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeetingEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeetingEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> audioFilePath = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeetingEntriesCompanion(
                id: id,
                title: title,
                createdAt: createdAt,
                audioFilePath: audioFilePath,
                durationSeconds: durationSeconds,
                status: status,
                errorMessage: errorMessage,
                tags: tags,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required DateTime createdAt,
                required String audioFilePath,
                required int durationSeconds,
                required String status,
                Value<String?> errorMessage = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeetingEntriesCompanion.insert(
                id: id,
                title: title,
                createdAt: createdAt,
                audioFilePath: audioFilePath,
                durationSeconds: durationSeconds,
                status: status,
                errorMessage: errorMessage,
                tags: tags,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MeetingEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeetingEntriesTable,
      MeetingEntry,
      $$MeetingEntriesTableFilterComposer,
      $$MeetingEntriesTableOrderingComposer,
      $$MeetingEntriesTableAnnotationComposer,
      $$MeetingEntriesTableCreateCompanionBuilder,
      $$MeetingEntriesTableUpdateCompanionBuilder,
      (
        MeetingEntry,
        BaseReferences<_$AppDatabase, $MeetingEntriesTable, MeetingEntry>,
      ),
      MeetingEntry,
      PrefetchHooks Function()
    >;
typedef $$TranscriptEntriesTableCreateCompanionBuilder =
    TranscriptEntriesCompanion Function({
      required String id,
      required String meetingId,
      required String fullText,
      required String languageCode,
      Value<String> segmentsJson,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$TranscriptEntriesTableUpdateCompanionBuilder =
    TranscriptEntriesCompanion Function({
      Value<String> id,
      Value<String> meetingId,
      Value<String> fullText,
      Value<String> languageCode,
      Value<String> segmentsJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$TranscriptEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $TranscriptEntriesTable> {
  $$TranscriptEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meetingId => $composableBuilder(
    column: $table.meetingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullText => $composableBuilder(
    column: $table.fullText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get segmentsJson => $composableBuilder(
    column: $table.segmentsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TranscriptEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TranscriptEntriesTable> {
  $$TranscriptEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meetingId => $composableBuilder(
    column: $table.meetingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullText => $composableBuilder(
    column: $table.fullText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get segmentsJson => $composableBuilder(
    column: $table.segmentsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TranscriptEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TranscriptEntriesTable> {
  $$TranscriptEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get meetingId =>
      $composableBuilder(column: $table.meetingId, builder: (column) => column);

  GeneratedColumn<String> get fullText =>
      $composableBuilder(column: $table.fullText, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get segmentsJson => $composableBuilder(
    column: $table.segmentsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TranscriptEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TranscriptEntriesTable,
          TranscriptEntry,
          $$TranscriptEntriesTableFilterComposer,
          $$TranscriptEntriesTableOrderingComposer,
          $$TranscriptEntriesTableAnnotationComposer,
          $$TranscriptEntriesTableCreateCompanionBuilder,
          $$TranscriptEntriesTableUpdateCompanionBuilder,
          (
            TranscriptEntry,
            BaseReferences<
              _$AppDatabase,
              $TranscriptEntriesTable,
              TranscriptEntry
            >,
          ),
          TranscriptEntry,
          PrefetchHooks Function()
        > {
  $$TranscriptEntriesTableTableManager(
    _$AppDatabase db,
    $TranscriptEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TranscriptEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TranscriptEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TranscriptEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> meetingId = const Value.absent(),
                Value<String> fullText = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<String> segmentsJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TranscriptEntriesCompanion(
                id: id,
                meetingId: meetingId,
                fullText: fullText,
                languageCode: languageCode,
                segmentsJson: segmentsJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String meetingId,
                required String fullText,
                required String languageCode,
                Value<String> segmentsJson = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => TranscriptEntriesCompanion.insert(
                id: id,
                meetingId: meetingId,
                fullText: fullText,
                languageCode: languageCode,
                segmentsJson: segmentsJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TranscriptEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TranscriptEntriesTable,
      TranscriptEntry,
      $$TranscriptEntriesTableFilterComposer,
      $$TranscriptEntriesTableOrderingComposer,
      $$TranscriptEntriesTableAnnotationComposer,
      $$TranscriptEntriesTableCreateCompanionBuilder,
      $$TranscriptEntriesTableUpdateCompanionBuilder,
      (
        TranscriptEntry,
        BaseReferences<_$AppDatabase, $TranscriptEntriesTable, TranscriptEntry>,
      ),
      TranscriptEntry,
      PrefetchHooks Function()
    >;
typedef $$MeetingOutputEntriesTableCreateCompanionBuilder =
    MeetingOutputEntriesCompanion Function({
      required String id,
      required String meetingId,
      required String type,
      required String markdownContent,
      required DateTime generatedAt,
      required String modelVersion,
      Value<int> rowid,
    });
typedef $$MeetingOutputEntriesTableUpdateCompanionBuilder =
    MeetingOutputEntriesCompanion Function({
      Value<String> id,
      Value<String> meetingId,
      Value<String> type,
      Value<String> markdownContent,
      Value<DateTime> generatedAt,
      Value<String> modelVersion,
      Value<int> rowid,
    });

class $$MeetingOutputEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $MeetingOutputEntriesTable> {
  $$MeetingOutputEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meetingId => $composableBuilder(
    column: $table.meetingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get markdownContent => $composableBuilder(
    column: $table.markdownContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MeetingOutputEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MeetingOutputEntriesTable> {
  $$MeetingOutputEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meetingId => $composableBuilder(
    column: $table.meetingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get markdownContent => $composableBuilder(
    column: $table.markdownContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MeetingOutputEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeetingOutputEntriesTable> {
  $$MeetingOutputEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get meetingId =>
      $composableBuilder(column: $table.meetingId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get markdownContent => $composableBuilder(
    column: $table.markdownContent,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => column,
  );
}

class $$MeetingOutputEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeetingOutputEntriesTable,
          MeetingOutputEntry,
          $$MeetingOutputEntriesTableFilterComposer,
          $$MeetingOutputEntriesTableOrderingComposer,
          $$MeetingOutputEntriesTableAnnotationComposer,
          $$MeetingOutputEntriesTableCreateCompanionBuilder,
          $$MeetingOutputEntriesTableUpdateCompanionBuilder,
          (
            MeetingOutputEntry,
            BaseReferences<
              _$AppDatabase,
              $MeetingOutputEntriesTable,
              MeetingOutputEntry
            >,
          ),
          MeetingOutputEntry,
          PrefetchHooks Function()
        > {
  $$MeetingOutputEntriesTableTableManager(
    _$AppDatabase db,
    $MeetingOutputEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeetingOutputEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeetingOutputEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MeetingOutputEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> meetingId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> markdownContent = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<String> modelVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeetingOutputEntriesCompanion(
                id: id,
                meetingId: meetingId,
                type: type,
                markdownContent: markdownContent,
                generatedAt: generatedAt,
                modelVersion: modelVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String meetingId,
                required String type,
                required String markdownContent,
                required DateTime generatedAt,
                required String modelVersion,
                Value<int> rowid = const Value.absent(),
              }) => MeetingOutputEntriesCompanion.insert(
                id: id,
                meetingId: meetingId,
                type: type,
                markdownContent: markdownContent,
                generatedAt: generatedAt,
                modelVersion: modelVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MeetingOutputEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeetingOutputEntriesTable,
      MeetingOutputEntry,
      $$MeetingOutputEntriesTableFilterComposer,
      $$MeetingOutputEntriesTableOrderingComposer,
      $$MeetingOutputEntriesTableAnnotationComposer,
      $$MeetingOutputEntriesTableCreateCompanionBuilder,
      $$MeetingOutputEntriesTableUpdateCompanionBuilder,
      (
        MeetingOutputEntry,
        BaseReferences<
          _$AppDatabase,
          $MeetingOutputEntriesTable,
          MeetingOutputEntry
        >,
      ),
      MeetingOutputEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MeetingEntriesTableTableManager get meetingEntries =>
      $$MeetingEntriesTableTableManager(_db, _db.meetingEntries);
  $$TranscriptEntriesTableTableManager get transcriptEntries =>
      $$TranscriptEntriesTableTableManager(_db, _db.transcriptEntries);
  $$MeetingOutputEntriesTableTableManager get meetingOutputEntries =>
      $$MeetingOutputEntriesTableTableManager(_db, _db.meetingOutputEntries);
}
