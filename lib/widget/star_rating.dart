import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.rating,
    this.ratingMaximum = 5,
    this.halfRatingAllowed = true,
    this.iconSize = 24.0,
    this.iconFull = const Icon(Icons.star),
    this.iconHalf = const Icon(Icons.star_half_outlined),
    this.iconEmpty = const Icon(Icons.star_border),
    this.ratingChangedCallback,
  });

  final double rating;
  final int ratingMaximum;
  final bool halfRatingAllowed;
  final double iconSize;
  final Icon iconFull;
  final Icon iconHalf;
  final Icon iconEmpty;
  final Function? ratingChangedCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(ratingMaximum, (index) {
        IconData? starIcon;

        if (rating > index && rating < index + 1) {
          starIcon = halfRatingAllowed ? iconHalf.icon : iconEmpty.icon;
        } else if (rating <= index) {
          starIcon = iconEmpty.icon;
        } else {
          starIcon = iconFull.icon;
        }

        // If Function is null, then Rating is disabled, pass the Icon only
        // This means view only, no modifying rating
        return ratingChangedCallback != null
            ? GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  final RenderBox renderBox =
                      context.findRenderObject() as RenderBox;
                  final Offset mouseFingerPosition =
                      renderBox.globalToLocal(details.globalPosition);
                  double rating = mouseFingerPosition.dx / iconSize;
                  rating = ((rating * 2).ceilToDouble() / 2)
                      .clamp(0.0, ratingMaximum.toDouble());
                  ratingChangedCallback!(rating);
                },
                onTap: () => ratingChangedCallback!(index + 1.0),
                child: Icon(
                  starIcon,
                  size: iconSize,
                ),
              )
            : Icon(
                starIcon,
                size: iconSize,
              );
      }),
    );
  }
}
