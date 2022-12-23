import 'package:delivery_app_example/common/dio/dio.dart';
import 'package:delivery_app_example/common/repository/base_pagination_repository.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../common/const/data.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/pagination_params.dart';
import '../../rating/model/rating_model.dart';

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider =
    Provider.family<RestaurantRatingRepository, String>((ref, id) {
  final dio = ref.watch(dioProvider);

  return RestaurantRatingRepository(dio, baseUrl: 'http://$ip/restaurant/$id/rating');
});

@RestApi()
abstract class RestaurantRatingRepository implements IBasePaginationRepository<RatingModel> {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) = _RestaurantRatingRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  @override
  Future<CursorPagination<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
