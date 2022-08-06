import 'package:tranquil_life/features/auth/domain/entities/user.dart';

class Client extends User {
  Client({
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.avatarUrl,
  });
}
