import 'package:tranquil_life/features/auth/data/repos/client_auth.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';

class ClientAuthBloc extends AuthBloc {
  @override
  final repo = const AuthRepoImpl();
}
