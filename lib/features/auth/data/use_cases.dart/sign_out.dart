import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/auth/domain/repos/user_data.dart';

final signOutCase = SignOutCase();

class SignOutCase {
  Future call() async {
    await getIt<IUserDataStore>().deleteUser();
  }
}
