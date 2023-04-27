import 'package:flutter/material.dart';

class ImageCircleShadow extends StatelessWidget {
  const ImageCircleShadow({
    super.key,
    required this.assetImageWithPath,
    required this.height,
  });

  final String assetImageWithPath;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: height,
      child: Material(
        type: MaterialType.circle,
        color: Colors.transparent,
        shadowColor: Theme.of(context).indicatorColor,
        elevation: 8.0,
        child: Image(
          image: AssetImage(assetImageWithPath),
        ),
      ),
    );
  }
}
