// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medicine _$MedicineFromJson(Map<String, dynamic> json) => Medicine(
      json['codice_aic'] as String,
      json['nome'] as String,
      json['prezzo'] as String,
    );

Map<String, dynamic> _$MedicineToJson(Medicine instance) => <String, dynamic>{
      'codice_aic': instance.codice_aic,
      'nome': instance.nome,
      'prezzo': instance.prezzo,
    };
