// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avail_medicine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailMedicine _$AvailMedicineFromJson(Map<String, dynamic> json) =>
    AvailMedicine(
      Pharmacy.fromJson(json['farmacia'] as Map<String, dynamic>),
      Medicine.fromJson(json['prodotto'] as Map<String, dynamic>),
      json['quantita'] as int,
    );

Map<String, dynamic> _$AvailMedicineToJson(AvailMedicine instance) =>
    <String, dynamic>{
      'farmacia': instance.farmacia.toJson(),
      'prodotto': instance.prodotto.toJson(),
      'quantita': instance.quantita,
    };
