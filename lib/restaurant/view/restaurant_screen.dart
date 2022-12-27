import 'package:delivery_app_example/common/component/pagination_list_view.dart';
import 'package:delivery_app_example/restaurant/component/restaurant_card.dart';
import 'package:delivery_app_example/restaurant/provider/restaurant_provider.dart';
import 'package:delivery_app_example/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
        provider: restaurantProvider,
        itemBuilder: <RestaurantModel>(_, index, model) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(id: model.id),
              ));
            },
            child: RestaurantCard.fromModel(model: model),
          );
        });
  }
}
