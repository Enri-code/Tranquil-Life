part of 'saved_note.dart';

Map<String, dynamic> _$SavedNoteToJson(SavedNote instance) => <String, dynamic>{
      'heading': instance.title,
      'body': instance.description,
      'emoji': instance.emoji,
      'color_int': instance.colorInt,
      'id': instance.id,
      //'updated_at': instance.dateUpdated?.toIso8601String(),
    };
