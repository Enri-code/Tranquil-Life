import 'package:tranquil_life/features/profile/domain/entities/user.dart';

class Consultant extends User {
  final int id;
  final String specialties;
  final String description;

  const Consultant({
    required this.id,
    required super.displayName,
    this.specialties = '',
    this.description = '',
    super.avatarUrl = '',
  });
}
