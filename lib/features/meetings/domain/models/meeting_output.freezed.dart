// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_output.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeetingOutput {

 String get id; String get meetingId; OutputType get type; String get markdownContent; DateTime get generatedAt; String get modelVersion;
/// Create a copy of MeetingOutput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingOutputCopyWith<MeetingOutput> get copyWith => _$MeetingOutputCopyWithImpl<MeetingOutput>(this as MeetingOutput, _$identity);

  /// Serializes this MeetingOutput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingOutput&&(identical(other.id, id) || other.id == id)&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.type, type) || other.type == type)&&(identical(other.markdownContent, markdownContent) || other.markdownContent == markdownContent)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.modelVersion, modelVersion) || other.modelVersion == modelVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,meetingId,type,markdownContent,generatedAt,modelVersion);

@override
String toString() {
  return 'MeetingOutput(id: $id, meetingId: $meetingId, type: $type, markdownContent: $markdownContent, generatedAt: $generatedAt, modelVersion: $modelVersion)';
}


}

/// @nodoc
abstract mixin class $MeetingOutputCopyWith<$Res>  {
  factory $MeetingOutputCopyWith(MeetingOutput value, $Res Function(MeetingOutput) _then) = _$MeetingOutputCopyWithImpl;
@useResult
$Res call({
 String id, String meetingId, OutputType type, String markdownContent, DateTime generatedAt, String modelVersion
});




}
/// @nodoc
class _$MeetingOutputCopyWithImpl<$Res>
    implements $MeetingOutputCopyWith<$Res> {
  _$MeetingOutputCopyWithImpl(this._self, this._then);

  final MeetingOutput _self;
  final $Res Function(MeetingOutput) _then;

/// Create a copy of MeetingOutput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? meetingId = null,Object? type = null,Object? markdownContent = null,Object? generatedAt = null,Object? modelVersion = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OutputType,markdownContent: null == markdownContent ? _self.markdownContent : markdownContent // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,modelVersion: null == modelVersion ? _self.modelVersion : modelVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingOutput].
extension MeetingOutputPatterns on MeetingOutput {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingOutput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingOutput() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingOutput value)  $default,){
final _that = this;
switch (_that) {
case _MeetingOutput():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingOutput value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingOutput() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String meetingId,  OutputType type,  String markdownContent,  DateTime generatedAt,  String modelVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingOutput() when $default != null:
return $default(_that.id,_that.meetingId,_that.type,_that.markdownContent,_that.generatedAt,_that.modelVersion);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String meetingId,  OutputType type,  String markdownContent,  DateTime generatedAt,  String modelVersion)  $default,) {final _that = this;
switch (_that) {
case _MeetingOutput():
return $default(_that.id,_that.meetingId,_that.type,_that.markdownContent,_that.generatedAt,_that.modelVersion);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String meetingId,  OutputType type,  String markdownContent,  DateTime generatedAt,  String modelVersion)?  $default,) {final _that = this;
switch (_that) {
case _MeetingOutput() when $default != null:
return $default(_that.id,_that.meetingId,_that.type,_that.markdownContent,_that.generatedAt,_that.modelVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingOutput implements MeetingOutput {
  const _MeetingOutput({required this.id, required this.meetingId, required this.type, required this.markdownContent, required this.generatedAt, required this.modelVersion});
  factory _MeetingOutput.fromJson(Map<String, dynamic> json) => _$MeetingOutputFromJson(json);

@override final  String id;
@override final  String meetingId;
@override final  OutputType type;
@override final  String markdownContent;
@override final  DateTime generatedAt;
@override final  String modelVersion;

/// Create a copy of MeetingOutput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingOutputCopyWith<_MeetingOutput> get copyWith => __$MeetingOutputCopyWithImpl<_MeetingOutput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingOutputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingOutput&&(identical(other.id, id) || other.id == id)&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.type, type) || other.type == type)&&(identical(other.markdownContent, markdownContent) || other.markdownContent == markdownContent)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.modelVersion, modelVersion) || other.modelVersion == modelVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,meetingId,type,markdownContent,generatedAt,modelVersion);

@override
String toString() {
  return 'MeetingOutput(id: $id, meetingId: $meetingId, type: $type, markdownContent: $markdownContent, generatedAt: $generatedAt, modelVersion: $modelVersion)';
}


}

/// @nodoc
abstract mixin class _$MeetingOutputCopyWith<$Res> implements $MeetingOutputCopyWith<$Res> {
  factory _$MeetingOutputCopyWith(_MeetingOutput value, $Res Function(_MeetingOutput) _then) = __$MeetingOutputCopyWithImpl;
@override @useResult
$Res call({
 String id, String meetingId, OutputType type, String markdownContent, DateTime generatedAt, String modelVersion
});




}
/// @nodoc
class __$MeetingOutputCopyWithImpl<$Res>
    implements _$MeetingOutputCopyWith<$Res> {
  __$MeetingOutputCopyWithImpl(this._self, this._then);

  final _MeetingOutput _self;
  final $Res Function(_MeetingOutput) _then;

/// Create a copy of MeetingOutput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? meetingId = null,Object? type = null,Object? markdownContent = null,Object? generatedAt = null,Object? modelVersion = null,}) {
  return _then(_MeetingOutput(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OutputType,markdownContent: null == markdownContent ? _self.markdownContent : markdownContent // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,modelVersion: null == modelVersion ? _self.modelVersion : modelVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
