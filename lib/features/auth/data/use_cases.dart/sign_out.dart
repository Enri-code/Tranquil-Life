import 'package:tranquil_life/core/utils/services/app_data_store.dart';

final signOutCase = SignOut();

class SignOut {
  Future call() async {
    await AppData.deleteUser();
  }
}
