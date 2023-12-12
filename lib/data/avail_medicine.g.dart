// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avail_medicine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailMedicine _$AvailMedicineFromJson(Map<String, dynamic> json) =>
    AvailMedicine(
      Pharmacy.fromJson(json['f'] as Map<String, dynamic>),
      json['qt'] as int,
    );

Map<String, dynamic> _$AvailMedicineToJson(AvailMedicine instance) =>
    <String, dynamic>{
      'f': instance.f.toJson(),
      'qt': instance.qt,
    };
