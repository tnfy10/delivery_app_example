import 'package:delivery_app_example/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_utils.dart';
import '../../product/model/product_model.dart';

part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<BaseProductModel> products;

  RestaurantDetailModel(
      {required super.id,
      required super.name,
      required super.thumbUrl,
      required super.tags,
      required super.priceRange,
      required super.ratings,
      required super.ratingsCount,
      required super.deliveryTime,
      required super.deliveryFee,
      required this.detail,
      required this.products});

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailModelFromJson(json);
}
