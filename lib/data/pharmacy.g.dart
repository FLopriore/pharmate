// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pharmacy _$PharmacyFromJson(Map<String, dynamic> json) => Pharmacy(
      json['nome'] as String,
      json['codice_farmacia'] as String,
      json['citta'] as String,
    );

Map<String, dynamic> _$PharmacyToJson(Pharmacy instance) => <String, dynamic>{
      'nome': instance.nome,
      'codice_farmacia': instance.codice_farmacia,
      'citta': instance.citta,
    };
