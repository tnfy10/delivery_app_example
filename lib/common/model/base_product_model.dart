import 'package:json_annotation/json_annotation.dart';

import '../utils/data_utils.dart';
import 'model_with_id.dart';

part 'base_product_model.g.dart';

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