import 'package:badges/badges.dart';
import 'package:delivery_app_example/common/const/colors.dart';
import 'package:delivery_app_example/common/layout/default_layout.dart';
import 'package:delivery_app_example/common/model/cursor_pagination_model.dart';
import 'package:delivery_app_example/product/component/product_card.dart';
import 'package:delivery_app_example/product/model/product_model.dart';
import 'package:delivery_app_example/restaurant/component/restaurant_card.dart';
import 'package:delivery_app_example/restaurant/model/restaurant_detail_model.dart';
import 'package:delivery_app_example/restaurant/provider/restaurant_provider.dart';
import 'package:delivery_app_example/restaurant/provider/restaurant_rating_provider.dart';
import 'package:delivery_app_example/user/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletons/skeletons.dart';

import '../../common/utils/pagination_utils.dart';
import '../../rating/component/rating_card.dart';
import '../../rating/model/rating_model.dart';
import 'basket_screen.dart';
import '../model/restaurant_model.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'restaurantDetail';

  final String id;

  const RestaurantDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends ConsumerState<RestaurantDetailScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);

    controller.addListener(listener);
  }

  void listener() {
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(restaurantRatingProvider(widget.id).notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingState = ref.watch(restaurantRatingProvider(widget.id));
    final basket = ref.watch(basketProvider);

    if (state == null) {
      return const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
        title: '불타는 떡볶이',
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed(BasketScreen.routeName);
          },
          backgroundColor: primaryColor,
          child: Badge(
            showBadge: basket.isNotEmpty,
            badgeContent: Text(
              basket
                  .fold<int>(
                    0,
                    (previous, next) => previous + next.count,
                  )
                  .toString(),
              style: const TextStyle(
                color: primaryColor,
                fontSize: 10,
              ),
            ),
            badgeColor: Colors.white,
            child: const Icon(
              Icons.shopping_basket_outlined,
            ),
          ),
        ),
        child: CustomScrollView(
          controller: controller,
          slivers: [
            _renderTop(model: state),
            if (state is! RestaurantDetailModel) renderLoading(),
            if (state is RestaurantDetailModel) _renderLabel(),
            if (state is RestaurantDetailModel)
              _renderProducts(
                products: state.products,
                restaurant: state,
              ),
            if (ratingState is CursorPagination<RatingModel>)
              renderRatings(
                models: ratingState.data,
              ),
          ],
        ));
  }

  SliverPadding renderRatings({
    required List<RatingModel> models,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: RatingCard.fromModel(
                model: models[index],
              ),
            );
          },
          childCount: models.length,
        ),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildListDelegate(List.generate(
            3,
            (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SkeletonParagraph(
                    style: const SkeletonParagraphStyle(
                      lines: 5,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ))),
      ),
    );
  }

  SliverPadding _renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text('메뉴', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      ),
    );
  }

  SliverPadding _renderProducts({
    required RestaurantModel restaurant,
    required List<BaseProductModel> products,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(childCount: products.length, (context, index) {
        final model = products[index];
        return InkWell(
          onTap: () {
            ref.read(basketProvider.notifier).addToBasket(
                  product: ProductModel(
                    id: model.id,
                    name: model.name,
                    detail: model.detail,
                    imgUrl: model.imgUrl,
                    price: model.price,
                    restaurant: restaurant,
                  ),
                );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ProductCard.fromRestaurantProductModel(model: model),
          ),
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
