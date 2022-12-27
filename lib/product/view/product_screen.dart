import 'package:delivery_app_example/common/component/pagination_list_view.dart';
import 'package:delivery_app_example/product/provider/product_provider.dart';
import 'package:flutter/material.dart';

import '../component/product_card.dart';
import '../model/product_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
        provider: productProvider,
        itemBuilder: <ProductModel>(_, index, model) {
          return ProductCard.fromProductModel(
            model: model,
          );
        });
  }
}
