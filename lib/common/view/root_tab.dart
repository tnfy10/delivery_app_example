import 'package:delivery_app_example/common/const/colors.dart';
import 'package:delivery_app_example/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        unselectedItemColor: bodyTextColor,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.fastfood_outlined,
              ),
              label: '음식'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.receipt_long_outlined,
              ),
              label: '주문'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outlined,
              ),
              label: '프로필'),
        ],
      ),
      child: const Center(
        child: Text('Root Tab'),
      ),
    );
  }
}
