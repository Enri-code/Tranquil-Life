// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedNoteModel _$SavedNoteModelFromJson(Map<String, dynamic> json) =>
    SavedNoteModel(
      id: json['id'] as String,
      dateUpdated: dateTimeFromString(json['updated_at'] as String),
      title: json['heading'] as String? ?? '',
      description: json['body'] as String? ?? '',
      mood: json['mood'] as String?,
      hexColor: json['color'] as String?,
    );
