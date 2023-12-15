// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UtenteFromJson(Map<String, dynamic> json) => User(
      json['cf'] as String,
      json['fullname'] as String,
      json['citta'] as String,
      Pharmacy.fromJson(json['favourite'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UtenteToJson(User instance) => <String, dynamic>{
      'cf': instance.cf,
      'fullname': instance.fullname,
      'citta': instance.citta,
      'favourite': instance.favourite.toJson(),
    };
