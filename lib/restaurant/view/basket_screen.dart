import 'package:delivery_app_example/common/const/colors.dart';
import 'package:delivery_app_example/common/layout/default_layout.dart';
import 'package:delivery_app_example/order/provider/order_provider.dart';
import 'package:delivery_app_example/order/view/order_done_screen.dart';
import 'package:delivery_app_example/product/component/product_card.dart';
import 'package:delivery_app_example/user/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BasketScreen extends ConsumerWidget {
  static String get routeName => 'basket';

  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    if (basket.isEmpty) {
      return const DefaultLayout(
        title: '장바구니',
        child: Center(
          child: Text(
            '장바구니가 비어있습니다 ㅠㅠ',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final productPrice = basket.fold(0, (p, n) => p + n.product.price * n.count);
    final deliveryFee = basket.first.product.restaurant.deliveryFee;

    return DefaultLayout(
      title: '장바구니',
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, index) {
                    return const Divider(
                      height: 32,
                    );
                  },
                  itemBuilder: (_, index) {
                    final model = basket[index];

                    return ProductCard.fromBaseProductModel(
                      model: model.product,
                      onSubtract: () {
                        ref.read(basketProvider.notifier).removeFromBasket(
                              product: model.product,
                            );
                      },
                      onAdd: () {
                        ref.read(basketProvider.notifier).addToBasket(
                              product: model.product,
                            );
                      },
                    );
                  },
                  itemCount: basket.length,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '장바구니 금액',
                        style: TextStyle(
                          color: bodyTextColor,
                        ),
                      ),
                      Text('₩$productPrice'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '배달비',
                        style: TextStyle(
                          color: bodyTextColor,
                        ),
                      ),
                      if (basket.isNotEmpty) Text('₩$deliveryFee'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '총액',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text('₩${productPrice + deliveryFee}'),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(orderProvider.notifier).postOrder().then((value) {
                      if (value) {
                        context.goNamed(OrderDoneScreen.routeName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('결제 실패!')),
                        );
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: const Text(
                    '결제하기',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
