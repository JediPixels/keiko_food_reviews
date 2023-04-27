import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/widget/image_circle_shadow.dart';

class ImageAndMessage extends StatelessWidget {
  const ImageAndMessage({
    super.key,
    this.topPadding = 0,
    this.iconHeight = 128.0,
    required this.assetImageWithPath,
    this.message = '',
  });

  final double topPadding;
  final double iconHeight;
  final String assetImageWithPath;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: kToolbarHeight + topPadding + iconHeight),
          ImageCircleShadow(
            assetImageWithPath: assetImageWithPath,
            height: iconHeight,
          ),
          const SizedBox(height: 8.0),
          message.isNotEmpty ? Text(message) : const SizedBox(),
        ],
      ),
    );
  }
}
