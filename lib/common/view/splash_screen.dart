import 'package:delivery_app_example/common/const/colors.dart';
import 'package:delivery_app_example/common/const/data.dart';
import 'package:delivery_app_example/common/layout/default_layout.dart';
import 'package:delivery_app_example/common/view/root_tab.dart';
import 'package:delivery_app_example/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // deleteToken();
    checkToken();
  }

  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: refreshTokenKey);
    final accessToken = await storage.read(key: accessTokenKey);

    final dio = Dio();

    try {
      final resp = await dio.post('http://$ip/auth/token',
          options: Options(headers: {'authorization': 'Bearer $refreshToken'}));

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const RootTab()), (route) => false);
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: primaryColor,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/logo/logo.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
