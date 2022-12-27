import 'package:delivery_app_example/common/const/colors.dart';
import 'package:delivery_app_example/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;

  const ProductCard(
      {Key? key,
      required this.image,
      required this.name,
      required this.detail,
      required this.price})
      : super(key: key);

  factory ProductCard.fromProductModel({
    required ProductModel model,
  }) {
    return ProductCard(
        image: Image.network(
          model.imgUrl,
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
        name: model.name,
        detail: model.detail,
        price: model.price);
  }

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel model,
  }) {
    return ProductCard(
        image: Image.network(
          model.imgUrl,
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
        name: model.name,
        detail: model.detail,
        price: model.price);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(8), child: image),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: bodyTextColor, fontSize: 14),
                ),
                Text(
                  '₩$price',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      color: primaryColor, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
