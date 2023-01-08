import 'package:json_annotation/json_annotation.dart';

import '../../common/model/base_product_model.dart';
import '../../common/utils/data_utils.dart';
import '../../restaurant/model/restaurant_model.dart';

part 'product_and_restaurant_model.g.dart';

@JsonSerializable()
class ProductAndRestaurantModel extends BaseProductModel {
  final RestaurantModel restaurant;

  ProductAndRestaurantModel({
    required super.id,
    required super.name,
    required super.detail,
    required super.imgUrl,
    required super.price,
    required this.restaurant,
  });

  factory ProductAndRestaurantModel.fromJson(Map<String, dynamic> json) => _$ProductAndRestaurantModelFromJson(json);
}
