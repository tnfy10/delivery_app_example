// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_and_restaurant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductAndRestaurantModel _$ProductAndRestaurantModelFromJson(
        Map<String, dynamic> json) =>
    ProductAndRestaurantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      detail: json['detail'] as String,
      imgUrl: DataUtils.pathToUrl(json['imgUrl'] as String),
      price: json['price'] as int,
      restaurant:
          RestaurantModel.fromJson(json['restaurant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductAndRestaurantModelToJson(
        ProductAndRestaurantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'detail': instance.detail,
      'imgUrl': instance.imgUrl,
      'price': instance.price,
      'restaurant': instance.restaurant,
    };
