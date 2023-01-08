// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseProductModel _$BaseProductModelFromJson(Map<String, dynamic> json) =>
    BaseProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      detail: json['detail'] as String,
      imgUrl: DataUtils.pathToUrl(json['imgUrl'] as String),
      price: json['price'] as int,
    );

Map<String, dynamic> _$BaseProductModelToJson(BaseProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'detail': instance.detail,
      'imgUrl': instance.imgUrl,
      'price': instance.price,
    };
