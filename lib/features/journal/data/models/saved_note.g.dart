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
      emoji: json['emoji'] as String?,
      colorInt: json['color_int'] as int? ?? 0xffACD5E8,
    );