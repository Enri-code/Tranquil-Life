import 'package:json_annotation/json_annotation.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';

part 'saved_note.g.dart';

@JsonSerializable(createFactory: true)
class SavedNoteModel extends SavedNote {
  SavedNoteModel({
    required super.id,
    required super.dateUpdated,
    super.title,
    super.description,
    super.emoji,
    super.hexColor,
  });

  factory SavedNoteModel.fromJson(Map<String, dynamic> json) =>
      _$SavedNoteModelFromJson(json);
}
