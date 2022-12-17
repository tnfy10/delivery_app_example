import 'package:delivery_app_example/restaurant/component/restaurant_card.dart';
import 'package:delivery_app_example/restaurant/provider/restaurant_provider.dart';
import 'package:delivery_app_example/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    if (data.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
            itemBuilder: (_, index) {
              final pItem = data[index];

              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            RestaurantDetailScreen(id: pItem.id)));
                  },
                  child: RestaurantCard.fromModel(model: pItem));
            },
            separatorBuilder: (_, index) {
              return const SizedBox(height: 16);
            },
            itemCount: data.length));
  }
}
