import 'package:delivery_app_example/common/model/cursor_pagination_model.dart';
import 'package:delivery_app_example/restaurant/component/restaurant_card.dart';
import 'package:delivery_app_example/restaurant/model/restaurant_model.dart';
import 'package:delivery_app_example/restaurant/repository/restaurant_repository.dart';
import 'package:delivery_app_example/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder<CursorPagination<RestaurantModel>>(
          future: ref.watch(restaurantRepositoryProvider).paginate(),
          builder: (context,
              AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.separated(
                itemBuilder: (_, index) {
                  final pItem = snapshot.data!.data[index];

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
                itemCount: snapshot.data!.data.length);
          },
        ),
      ),
    );
  }
}
