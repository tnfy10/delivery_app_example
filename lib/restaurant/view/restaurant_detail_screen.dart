import 'dart:convert';

import 'package:delivery_app_example/common/layout/default_layout.dart';
import 'package:delivery_app_example/product/component/product_card.dart';
import 'package:delivery_app_example/restaurant/component/restaurant_card.dart';
import 'package:delivery_app_example/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/const/data.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;

  const RestaurantDetailScreen({Key? key, required this.id}) : super(key: key);

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();

    final accessToken = await storage.read(key: accessTokenKey);

    final resp = await dio.get('http://$ip/restaurant/$id',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}));

    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '불타는 떡볶이',
        child: FutureBuilder<Map<String, dynamic>>(
          future: getRestaurantDetail(),
          builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final item = RestaurantDetailModel.fromJson(json: snapshot.data!);

            return CustomScrollView(
              slivers: [
                _renderTop(model: item),
                _renderLabel(),
                _renderProducts()
              ],
            );
          },
        ));
  }

  SliverPadding _renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text('메뉴',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      ),
    );
  }

  SliverPadding _renderProducts() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
          delegate:
              SliverChildBuilderDelegate(childCount: 10, (context, index) {
        return const Padding(
          padding: EdgeInsets.only(top: 16),
          child: ProductCard(),
        );
      })),
    );
  }

  SliverToBoxAdapter _renderTop({required RestaurantDetailModel model}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(model: model, isDetail: true),
    );
  }
}
