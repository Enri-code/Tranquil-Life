import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable(createToJson: true)
class Note {
  @JsonKey(name: 'heading')
  String title;
  @JsonKey(name: 'body')
  String description;
  String? emoji;
  String? hexColor;

  Note({this.title = '', this.description = '', this.emoji, this.hexColor});

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
