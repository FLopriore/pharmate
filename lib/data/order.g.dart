// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      json['id'] as int,
      json['item'] as String,
      json['qta'] as int,
      $enumDecode(_$StatusEnumMap, json['status']),
      json['pharmacy'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'item': instance.item,
      'qta': instance.qta,
      'status': _$StatusEnumMap[instance.status]!,
      'pharmacy': instance.pharmacy,
    };

const _$StatusEnumMap = {
  Status.red: 'red',
  Status.yellow: 'yellow',
  Status.green: 'green',
};
