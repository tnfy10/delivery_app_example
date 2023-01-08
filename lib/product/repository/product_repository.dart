import 'package:delivery_app_example/common/model/pagination_params.dart';
import 'package:delivery_app_example/common/repository/base_pagination_repository.dart';
import 'package:delivery_app_example/product/model/product_and_restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../common/model/cursor_pagination_model.dart';

part 'product_repository.g.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return ProductRepository(dio, baseUrl: 'http://$ip/product');
  },
);

@RestApi()
abstract class ProductRepository implements IBasePaginationRepository<ProductAndRestaurantModel> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @override
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<ProductAndRestaurantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
