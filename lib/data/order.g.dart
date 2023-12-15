// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      json['uuid'] as String,
      Medicine.fromJson(json['prodotto'] as Map<String, dynamic>),
      json['quantita'] as int,
      $enumDecode(_$StatusEnumMap, json['status']),
      json['date'] as String,
      Pharmacy.fromJson(json['farmacia'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'prodotto': instance.prodotto.toJson(),
      'quantita': instance.quantita,
      'status': _$StatusEnumMap[instance.status]!,
      'date': instance.date,
      'farmacia': instance.farmacia.toJson(),
    };

const _$StatusEnumMap = {
  Status.PENDING: 'PENDING',
  Status.ACCEPTED: 'ACCEPTED',
  Status.DELIVERED: 'DELIVERED',
};
