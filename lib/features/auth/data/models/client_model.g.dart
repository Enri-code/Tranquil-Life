// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientModel _$ClientModelFromJson(Map<String, dynamic> json) => ClientModel(
      email: json['email'] as String,
      firstName: json['f_name'] as String,
      lastName: json['l_name'] as String,
      avatarUrl: json['avatar_url'] as String,
      token: json['token'] as String,
      id: json['id'] as int,
      displayName: json['display_name'] as String,
      phoneNumber: json['phone'] as String,
      birthDate:
          '${json['day_of_birth']}-${json['month_of_birth']}-${json['year_of_birth']}',
      isVerified: isVerifiedFromJson(json['email_verified_at']),
    );
