import 'package:delivery_app_example/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class RatingCard extends StatelessWidget {
  // NetworkImage
  // AssetImage
  //
  // CircleAvatar
  final ImageProvider avatarImage;

  // 리스트로 위젯 이미지를 보여줄 때
  final List<Image> images;

  // 별점
  final int rating;

  // 이메일
  final String email;

  // 리뷰 내용
  final String content;

  const RatingCard(
      {Key? key,
      required this.avatarImage,
      required this.images,
      required this.rating,
      required this.email,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avatarImage: avatarImage,
          email: email,
          rating: rating,
        ),
        const SizedBox(height: 8),
        _Body(
          content: content,
        ),
        if (images.isNotEmpty)
          SizedBox(
            child: _Images(
              images: images,
            ),
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final String email;
  final int rating;

  const _Header({Key? key, required this.avatarImage, required this.email, required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: avatarImage,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        ...List.generate(
            5,
            (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border_outlined,
                  color: primaryColor,
                ))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;

  const _Body({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Text(
          content,
          style: const TextStyle(color: bodyTextColor, fontSize: 14),
        )),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  final List<Image> images;

  const _Images({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: images
          .mapIndexed((index, e) => Padding(
                padding: EdgeInsets.only(right: index == images.length - 1 ? 0 : 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: e,
                ),
              ))
          .toList(),
    );
  }
}
