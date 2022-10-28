// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SavedNoteToJson(SavedNote instance) => <String, dynamic>{
      'id': instance.id,
      'heading': instance.title,
      'body': instance.description,
      'mood': instance.mood,
      'hex_color': instance.hexColor,
      'updated_at': instance.dateUpdated?.toIso8601String(),
    };
