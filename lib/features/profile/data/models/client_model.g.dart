// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../profile/data/models/client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientModel _$ClientModelFromJson(Map<String, dynamic> json) {
  return ClientModel(
    id: json['id'] as int,
    email: json['email'] as String,
    firstName: json['f_name'] as String,
    lastName: json['l_name'] as String,
    displayName: json['display_name'] as String,
    birthDate: json['birth_date'],
    avatarUrl: json['avatar_url'] as String,
    usesBitmoji: json['uses_bitmoji'],
    phoneNumber: json['phone'] as String,
    gender: json['gender'],
    staffId: json['staff_id'],
    companyName: json['company_name'] as String,
    isVerified: json['is_verified'],
    hasAnsweredQuestions: json['has_answered_questions'],
    token: json['auth_token'] as String,
  );
}
