import 'package:delivery_app_example/common/const/colors.dart';
import 'package:delivery_app_example/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

import '../model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image;
  final String name;
  final List<String> tags;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final double ratings;
  final bool isDetail;
  final String? heroKey;
  final String? detail;

  const RestaurantCard({
    Key? key,
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    this.isDetail = false,
    this.detail,
    this.heroKey,
  }) : super(key: key);

  factory RestaurantCard.fromModel({required RestaurantModel model, bool isDetail = false}) {
    return RestaurantCard(
        image: Image.network(model.thumbUrl, fit: BoxFit.cover),
        heroKey: model.id,
        name: model.name,
        tags: model.tags,
        ratingsCount: model.ratingsCount,
        deliveryTime: model.deliveryTime,
        deliveryFee: model.deliveryFee,
        ratings: model.ratings,
        isDetail: isDetail,
        detail: model is RestaurantDetailModel ? model.detail : null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        heroKey != null
            ? Hero(
                tag: ObjectKey(heroKey),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isDetail ? 0 : 12),
                  child: image,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(isDetail ? 0 : 12),
                child: image,
              ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                tags.join(' · '),
                style: const TextStyle(color: bodyTextColor, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _IconText(icon: Icons.star, label: ratings.toString()),
                  renderDot(),
                  _IconText(icon: Icons.receipt, label: ratingsCount.toString()),
                  renderDot(),
                  _IconText(icon: Icons.timelapse_outlined, label: '$deliveryTime 분'),
                  renderDot(),
                  _IconText(
                      icon: Icons.monetization_on,
                      label: '${deliveryFee == 0 ? '무료' : deliveryFee}'),
                ],
              ),
              if (detail != null && isDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(detail!),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '·',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({Key? key, required this.icon, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 14),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
