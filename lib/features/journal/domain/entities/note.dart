import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable(createToJson: true)
class Note {
  @JsonKey(name: 'heading')
  final String title;
  @JsonKey(name: 'body')
  final String description;
  final String? emoji;
  final int colorInt;

  const Note({
    this.title = '',
    this.description = '',
    this.emoji,
    this.colorInt = 0xffACD5E8,
  });

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
