import 'package:json_annotation/json_annotation.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';

part 'saved_note.g.dart';

@JsonSerializable(createToJson: true)
class SavedNote extends Note {
  const SavedNote({
    required this.id,
    required this.dateUpdated,
    super.title,
    super.description,
    super.emoji,
    super.hexColor,
  });

  final String id;
  @JsonKey(fromJson: dateTimeFromString, name: 'updated_at')
  final DateTime? dateUpdated;

  @override
  Map<String, dynamic> toJson() => _$SavedNoteToJson(this);
}

DateTime? dateTimeFromString(String time) {
  return DateTime.tryParse(time);
}
