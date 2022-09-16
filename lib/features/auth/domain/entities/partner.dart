import 'package:json_annotation/json_annotation.dart';

class Partner {
  const Partner({required this.id, required this.name, required this.logoUrl});

  final int id;
  final String name;
  @JsonKey(name: 'logo')
  final String logoUrl;
}
