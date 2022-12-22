import 'package:delivery_app_example/common/model/cursor_pagination_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/restaurant_rating_repository.dart';

class RestaurantRatingStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRatingRepository repository;

  RestaurantRatingStateNotifier({required this.repository}) : super(CursorPaginationLoading());
}