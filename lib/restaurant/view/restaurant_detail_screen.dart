import 'package:delivery_app_example/common/layout/default_layout.dart';
import 'package:delivery_app_example/product/component/product_card.dart';
import 'package:delivery_app_example/restaurant/component/restaurant_card.dart';
import 'package:delivery_app_example/restaurant/model/restaurant_detail_model.dart';
import 'package:delivery_app_example/restaurant/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/restaurant_model.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;

  const RestaurantDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(restaurantDetailProvider(id));

    if (state == null) {
      return const DefaultLayout(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    }

    return DefaultLayout(
        title: '불타는 떡볶이',
        child: CustomScrollView(
          slivers: [
            _renderTop(model: state),
            // _renderLabel(),
            // _renderProducts(products: snapshot.data!.products)
          ],
        ));
  }

  SliverPadding _renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text('메뉴', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      ),
    );
  }

  SliverPadding _renderProducts({required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(childCount: products.length, (context, index) {
        final model = products[index];
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ProductCard.fromModel(model: model),
        );
      })),
    );
  }

  SliverToBoxAdapter _renderTop({required RestaurantModel model}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(model: model, isDetail: true),
    );
  }
}
