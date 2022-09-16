import 'package:tranquil_life/app/domain/entities/query_params.dart';

class RegisterData extends QueryParams {
  RegisterData();

  String firstName = '';
  String lastName = '';
  String displayName = '';
  String email = '';
  String phone = '';
  String birthDate = '';
  String password = '';
  int? companyId;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'f_name': firstName,
      'l_name': lastName,
      'username': displayName,
      'email': email,
      'password': password,
      'phone': phone,
      'company_id': companyId,
      'birth_date': birthDate,
    };
  }
}
