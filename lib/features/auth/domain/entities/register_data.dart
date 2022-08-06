import 'package:tranquil_life/app/domain/entities/query_params.dart';

class RegisterData extends QueryParams {
  RegisterData();

  String firstName = '';
  String lastName = '';
  String displayName = '';
  String email = '';
  String password = '';
  String phone = '';
  String companyId = '';
  String birthDate = '';

  @override
  Map<String, dynamic> toJson() {
    var dates = birthDate.split('-').map((e) => int.parse(e)).toList();
    return <String, dynamic>{
      'f_name': firstName,
      'l_name': lastName,
      'username': displayName,
      'email': email,
      'password': password,
      'phone': phone,
      'company_id': companyId,
      'day_of_birth': dates[0],
      'month_of_birth': dates[1],
      'year_of_birth': dates[2],
    };
  }
}
