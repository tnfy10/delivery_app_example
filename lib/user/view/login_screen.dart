import 'dart:convert';

import 'package:delivery_app_example/common/const/colors.dart';
import 'package:delivery_app_example/common/const/data.dart';
import 'package:delivery_app_example/common/secure_storage/secure_storage.dart';
import 'package:delivery_app_example/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/layout/default_layout.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return DefaultLayout(
      child: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const _Title(),
                const SizedBox(height: 16),
                const _SubTitle(),
                Image.asset('asset/img/misc/logo.png',
                    width: MediaQuery.of(context).size.width / 3 * 2),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요',
                  onChanged: (value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요',
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () async {
                      final rawString = '$username:$password';
                      final stringToBase64 = utf8.fuse(base64);
                      final token = stringToBase64.encode(rawString);

                      final resp = await dio.post('http://$ip/auth/login',
                          options: Options(
                              headers: {'authorization': 'Basic $token'}));

                      final refreshToken = resp.data['refreshToken'];
                      final accessToken = resp.data['accessToken'];

                      final storage = ref.read(secureStorageProvider);

                      storage.write(key: refreshTokenKey, value: refreshToken);
                      storage.write(key: accessTokenKey, value: accessToken);

                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const RootTab()));
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    child: const Text(
                      '로그인',
                    )),
                TextButton(
                    onPressed: () async {},
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    child: const Text('회원가입'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다!',
      style: TextStyle(
          fontSize: 34, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(fontSize: 16, color: bodyTextColor),
    );
  }
}
