// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'heading': instance.title,
      'body': instance.description,
      if (instance.mood != null) 'mood': instance.mood,
      'hex_color': instance.hexColor,
    };
