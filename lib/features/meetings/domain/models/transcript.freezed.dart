// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transcript.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TranscriptSegment {

 int get id; double get start; double get end; String get text; double get avgLogprob;
/// Create a copy of TranscriptSegment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptSegmentCopyWith<TranscriptSegment> get copyWith => _$TranscriptSegmentCopyWithImpl<TranscriptSegment>(this as TranscriptSegment, _$identity);

  /// Serializes this TranscriptSegment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranscriptSegment&&(identical(other.id, id) || other.id == id)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.text, text) || other.text == text)&&(identical(other.avgLogprob, avgLogprob) || other.avgLogprob == avgLogprob));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,start,end,text,avgLogprob);

@override
String toString() {
  return 'TranscriptSegment(id: $id, start: $start, end: $end, text: $text, avgLogprob: $avgLogprob)';
}


}

/// @nodoc
abstract mixin class $TranscriptSegmentCopyWith<$Res>  {
  factory $TranscriptSegmentCopyWith(TranscriptSegment value, $Res Function(TranscriptSegment) _then) = _$TranscriptSegmentCopyWithImpl;
@useResult
$Res call({
 int id, double start, double end, String text, double avgLogprob
});




}
/// @nodoc
class _$TranscriptSegmentCopyWithImpl<$Res>
    implements $TranscriptSegmentCopyWith<$Res> {
  _$TranscriptSegmentCopyWithImpl(this._self, this._then);

  final TranscriptSegment _self;
  final $Res Function(TranscriptSegment) _then;

/// Create a copy of TranscriptSegment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? start = null,Object? end = null,Object? text = null,Object? avgLogprob = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as double,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as double,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,avgLogprob: null == avgLogprob ? _self.avgLogprob : avgLogprob // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TranscriptSegment].
extension TranscriptSegmentPatterns on TranscriptSegment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranscriptSegment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranscriptSegment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranscriptSegment value)  $default,){
final _that = this;
switch (_that) {
case _TranscriptSegment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranscriptSegment value)?  $default,){
final _that = this;
switch (_that) {
case _TranscriptSegment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  double start,  double end,  String text,  double avgLogprob)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranscriptSegment() when $default != null:
return $default(_that.id,_that.start,_that.end,_that.text,_that.avgLogprob);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  double start,  double end,  String text,  double avgLogprob)  $default,) {final _that = this;
switch (_that) {
case _TranscriptSegment():
return $default(_that.id,_that.start,_that.end,_that.text,_that.avgLogprob);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  double start,  double end,  String text,  double avgLogprob)?  $default,) {final _that = this;
switch (_that) {
case _TranscriptSegment() when $default != null:
return $default(_that.id,_that.start,_that.end,_that.text,_that.avgLogprob);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TranscriptSegment implements TranscriptSegment {
  const _TranscriptSegment({required this.id, required this.start, required this.end, required this.text, this.avgLogprob = 1.0});
  factory _TranscriptSegment.fromJson(Map<String, dynamic> json) => _$TranscriptSegmentFromJson(json);

@override final  int id;
@override final  double start;
@override final  double end;
@override final  String text;
@override@JsonKey() final  double avgLogprob;

/// Create a copy of TranscriptSegment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranscriptSegmentCopyWith<_TranscriptSegment> get copyWith => __$TranscriptSegmentCopyWithImpl<_TranscriptSegment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranscriptSegmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranscriptSegment&&(identical(other.id, id) || other.id == id)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.text, text) || other.text == text)&&(identical(other.avgLogprob, avgLogprob) || other.avgLogprob == avgLogprob));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,start,end,text,avgLogprob);

@override
String toString() {
  return 'TranscriptSegment(id: $id, start: $start, end: $end, text: $text, avgLogprob: $avgLogprob)';
}


}

/// @nodoc
abstract mixin class _$TranscriptSegmentCopyWith<$Res> implements $TranscriptSegmentCopyWith<$Res> {
  factory _$TranscriptSegmentCopyWith(_TranscriptSegment value, $Res Function(_TranscriptSegment) _then) = __$TranscriptSegmentCopyWithImpl;
@override @useResult
$Res call({
 int id, double start, double end, String text, double avgLogprob
});




}
/// @nodoc
class __$TranscriptSegmentCopyWithImpl<$Res>
    implements _$TranscriptSegmentCopyWith<$Res> {
  __$TranscriptSegmentCopyWithImpl(this._self, this._then);

  final _TranscriptSegment _self;
  final $Res Function(_TranscriptSegment) _then;

/// Create a copy of TranscriptSegment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? start = null,Object? end = null,Object? text = null,Object? avgLogprob = null,}) {
  return _then(_TranscriptSegment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as double,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as double,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,avgLogprob: null == avgLogprob ? _self.avgLogprob : avgLogprob // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Transcript {

 String get id; String get meetingId; String get fullText; String get languageCode; List<TranscriptSegment> get segments; DateTime get createdAt;
/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptCopyWith<Transcript> get copyWith => _$TranscriptCopyWithImpl<Transcript>(this as Transcript, _$identity);

  /// Serializes this Transcript to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transcript&&(identical(other.id, id) || other.id == id)&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.fullText, fullText) || other.fullText == fullText)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&const DeepCollectionEquality().equals(other.segments, segments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,meetingId,fullText,languageCode,const DeepCollectionEquality().hash(segments),createdAt);

@override
String toString() {
  return 'Transcript(id: $id, meetingId: $meetingId, fullText: $fullText, languageCode: $languageCode, segments: $segments, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TranscriptCopyWith<$Res>  {
  factory $TranscriptCopyWith(Transcript value, $Res Function(Transcript) _then) = _$TranscriptCopyWithImpl;
@useResult
$Res call({
 String id, String meetingId, String fullText, String languageCode, List<TranscriptSegment> segments, DateTime createdAt
});




}
/// @nodoc
class _$TranscriptCopyWithImpl<$Res>
    implements $TranscriptCopyWith<$Res> {
  _$TranscriptCopyWithImpl(this._self, this._then);

  final Transcript _self;
  final $Res Function(Transcript) _then;

/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? meetingId = null,Object? fullText = null,Object? languageCode = null,Object? segments = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as String,fullText: null == fullText ? _self.fullText : fullText // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,segments: null == segments ? _self.segments : segments // ignore: cast_nullable_to_non_nullable
as List<TranscriptSegment>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Transcript].
extension TranscriptPatterns on Transcript {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transcript value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transcript() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transcript value)  $default,){
final _that = this;
switch (_that) {
case _Transcript():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transcript value)?  $default,){
final _that = this;
switch (_that) {
case _Transcript() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String meetingId,  String fullText,  String languageCode,  List<TranscriptSegment> segments,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transcript() when $default != null:
return $default(_that.id,_that.meetingId,_that.fullText,_that.languageCode,_that.segments,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String meetingId,  String fullText,  String languageCode,  List<TranscriptSegment> segments,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Transcript():
return $default(_that.id,_that.meetingId,_that.fullText,_that.languageCode,_that.segments,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String meetingId,  String fullText,  String languageCode,  List<TranscriptSegment> segments,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Transcript() when $default != null:
return $default(_that.id,_that.meetingId,_that.fullText,_that.languageCode,_that.segments,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Transcript implements Transcript {
  const _Transcript({required this.id, required this.meetingId, required this.fullText, required this.languageCode, final  List<TranscriptSegment> segments = const [], required this.createdAt}): _segments = segments;
  factory _Transcript.fromJson(Map<String, dynamic> json) => _$TranscriptFromJson(json);

@override final  String id;
@override final  String meetingId;
@override final  String fullText;
@override final  String languageCode;
 final  List<TranscriptSegment> _segments;
@override@JsonKey() List<TranscriptSegment> get segments {
  if (_segments is EqualUnmodifiableListView) return _segments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_segments);
}

@override final  DateTime createdAt;

/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranscriptCopyWith<_Transcript> get copyWith => __$TranscriptCopyWithImpl<_Transcript>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranscriptToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transcript&&(identical(other.id, id) || other.id == id)&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.fullText, fullText) || other.fullText == fullText)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&const DeepCollectionEquality().equals(other._segments, _segments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,meetingId,fullText,languageCode,const DeepCollectionEquality().hash(_segments),createdAt);

@override
String toString() {
  return 'Transcript(id: $id, meetingId: $meetingId, fullText: $fullText, languageCode: $languageCode, segments: $segments, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TranscriptCopyWith<$Res> implements $TranscriptCopyWith<$Res> {
  factory _$TranscriptCopyWith(_Transcript value, $Res Function(_Transcript) _then) = __$TranscriptCopyWithImpl;
@override @useResult
$Res call({
 String id, String meetingId, String fullText, String languageCode, List<TranscriptSegment> segments, DateTime createdAt
});




}
/// @nodoc
class __$TranscriptCopyWithImpl<$Res>
    implements _$TranscriptCopyWith<$Res> {
  __$TranscriptCopyWithImpl(this._self, this._then);

  final _Transcript _self;
  final $Res Function(_Transcript) _then;

/// Create a copy of Transcript
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? meetingId = null,Object? fullText = null,Object? languageCode = null,Object? segments = null,Object? createdAt = null,}) {
  return _then(_Transcript(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as String,fullText: null == fullText ? _self.fullText : fullText // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,segments: null == segments ? _self._segments : segments // ignore: cast_nullable_to_non_nullable
as List<TranscriptSegment>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
