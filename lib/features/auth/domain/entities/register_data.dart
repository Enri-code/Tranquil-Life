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
  String? staffId;
  int? companyId;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'f_name': firstName,
      'l_name': lastName,
      'display_name': displayName,
      'birth_date': birthDate,
      'phone': phone,
      'staff_id': staffId,
      'company_id': companyId,
      'email': email,
      'password': password,
    };
  }
}
