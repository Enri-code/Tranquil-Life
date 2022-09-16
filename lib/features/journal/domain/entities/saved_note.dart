import 'package:json_annotation/json_annotation.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';

part 'saved_note.g.dart';

@JsonSerializable(createToJson: true)
class SavedNote extends Note {
  SavedNote({
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
  operator ==(dynamic other) => other is SavedNote && other.id == id;

  @override
  Map<String, dynamic> toJson() => _$SavedNoteToJson(this);

  @override
  @JsonKey(ignore: true)
  int get hashCode => super.hashCode & id.hashCode;
}

DateTime? dateTimeFromString(String time) => DateTime.tryParse(time);
