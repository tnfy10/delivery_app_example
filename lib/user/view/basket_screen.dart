import 'package:delivery_app_example/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class BasketScreen extends StatelessWidget {
  static String get routeName => 'basket';

  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '장바구니',
      child: Column(
        children: [],
      ),
    );
  }
}
