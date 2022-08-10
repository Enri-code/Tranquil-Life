import 'package:tranquil_life/core/utils/services/app_data_store.dart';

final signOutCase = SignOutCase();

class SignOutCase {
  Future call() async {
    await AppData.deleteUser();
  }
}
