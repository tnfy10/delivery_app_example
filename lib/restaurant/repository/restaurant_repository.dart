import 'package:delivery_app_example/common/dio/dio.dart';
import 'package:delivery_app_example/common/model/cursor_pagination_model.dart';
import 'package:delivery_app_example/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../common/const/data.dart';
import '../../common/model/pagination_params.dart';
import '../model/restaurant_model.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final repository =
      RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
  return repository;
});

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<RestaurantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<RestaurantDetailModel> getRestaurantDetail(
      {@Path() required String id});
}
