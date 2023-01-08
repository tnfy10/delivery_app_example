import 'package:delivery_app_example/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_utils.dart';
import '../../restaurant/model/restaurant_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class BaseProductModel implements IModelWithId {
  @override
  final String id;
  final String name;
  final String detail;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  final String imgUrl;
  final int price;

  BaseProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  factory BaseProductModel.fromJson(Map<String, dynamic> json) =>
      _$BaseProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseProductModelToJson(this);
}

@JsonSerializable()
class ProductModel extends BaseProductModel {
  final RestaurantModel restaurant;

  ProductModel({
    required super.id,
    required super.name,
    required super.detail,
    required super.imgUrl,
    required super.price,
    required this.restaurant,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}
