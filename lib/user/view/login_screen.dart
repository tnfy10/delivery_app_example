import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:delivery_app_example/common/const/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/layout/default_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    const emulatorIp = '10.0.2.2:3000';
    const simulatorIp = '127.0.0.1:3000';

    final ip = Platform.isIOS ? simulatorIp : emulatorIp;

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
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요',
                  onChanged: (value) {},
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () async {
                      const rawString = 'test@codefactory.ai:testtest';
                      final stringToBase64 = utf8.fuse(base64);
                      final token = stringToBase64.encode(rawString);

                      final resp = await dio.post('http://$ip/auth/login',
                          options: Options(
                              headers: {'authorization': 'Basic $token'}));
                    },
                    style: ElevatedButton.styleFrom(primary: PRIMARY_COLOR),
                    child: const Text(
                      '로그인',
                    )),
                TextButton(
                    onPressed: () async {
                      const refreshToken =
                          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTY3MDU5MTkxMSwiZXhwIjoxNjcwNjc4MzExfQ.4W29u-_y0UJAir3Tso7VZhL5g_tYIcjXABMKasL-fyY';

                      final resp = await dio.post('http://$ip/auth/token',
                          options: Options(
                              headers: {'authorization': 'Bearer $refreshToken'}));
                    },
                    style: TextButton.styleFrom(primary: Colors.black),
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
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
