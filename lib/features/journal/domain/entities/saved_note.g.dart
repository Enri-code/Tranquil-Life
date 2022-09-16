// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SavedNoteToJson(SavedNote instance) => <String, dynamic>{
      'heading': instance.title,
      'body': instance.description,
      'emoji': instance.emoji,
      'hex_color': instance.hexColor,
      'id': instance.id,
      'updated_at': instance.dateUpdated?.toIso8601String(),
    };
