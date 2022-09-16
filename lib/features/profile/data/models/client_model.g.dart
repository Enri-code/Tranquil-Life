// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../profile/data/models/client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientModel _$ClientModelFromJson(Map<String, dynamic> json) {
  return ClientModel(
    email: json['email'] as String,
    firstName: json['f_name'] as String,
    lastName: json['l_name'] as String,
    avatarUrl: json['avatar_url'] as String,
    token: json['token'] as String,
    id: json['id'] as int,
    displayName: json['display_name'] as String,
    phoneNumber: json['phone'] as String,
    hasAnsweredQuestions: json['has_answered_questions'] ?? false,
    usesBitmoji: json['uses_bitmoji'] ?? false,
    birthDate: json['birth_date'],
    isVerified: isVerifiedFromJson(json['email_verified_at']),
    gender: json['gender'],
  );
}
