import 'package:tranquil_life/features/auth/domain/entities/user.dart';

class Consultant extends User {
  final String specialties;
  final String description;

  const Consultant({
    required super.id,
    required super.displayName,
    this.specialties = '',
    this.description = '',
    super.avatarUrl = '',
  });
}
