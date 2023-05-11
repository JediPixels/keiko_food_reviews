import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/helper/constants.dart';
import 'package:keiko_food_reviews/logic/review_entry_edit_logic.dart';
import 'package:keiko_food_reviews/widget/star_rating.dart';

class ReviewEntryEditRatingAffordability extends StatelessWidget {
  const ReviewEntryEditRatingAffordability({
    super.key,
    required ReviewEntryEditLogic reviewEntryEditLogic,
    required ValueNotifier<double> ratingNotifier,
    required ValueNotifier<Affordability> affordabilityNotifier,
  })  : _reviewEntryEditLogic = reviewEntryEditLogic,
        _ratingNotifier = ratingNotifier,
        _affordabilityNotifier = affordabilityNotifier;

  final ReviewEntryEditLogic _reviewEntryEditLogic;
  final ValueNotifier<double> _ratingNotifier;
  final ValueNotifier<Affordability> _affordabilityNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ValueListenableBuilder(
          valueListenable: _ratingNotifier,
          builder: (
            BuildContext context,
            double rating,
            Widget? widget,
          ) {
            return StarRating(
              rating: _reviewEntryEditLogic.reviewEditModel.rating,
              ratingMaximum: 5,
              halfRatingAllowed: true,
              iconFull: const Icon(Icons.star),
              iconHalf: const Icon(Icons.star_half_outlined),
              iconEmpty: const Icon(Icons.star_border),
              ratingChangedCallback: (ratingSelected) {
                _reviewEntryEditLogic.reviewEditModel = _reviewEntryEditLogic
                    .reviewEditModel
                    .copyWith(rating: ratingSelected);
                _ratingNotifier.value =
                    _reviewEntryEditLogic.reviewEditModel.rating;
              },
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: _affordabilityNotifier,
          builder: (
            BuildContext context,
            Affordability affordability,
            Widget? widget,
          ) {
            return Flexible(
              child: SegmentedButton<Affordability>(
                style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: Theme.of(context).splashColor,
                        strokeAlign: -8.0,
                      ),
                    )),
                showSelectedIcon: false,
                segments: <ButtonSegment<Affordability>>[
                  ButtonSegment<Affordability>(
                    value: Affordability.$,
                    label: Text(Affordability.$.name),
                  ),
                  ButtonSegment<Affordability>(
                    value: Affordability.$$,
                    label: Text(Affordability.$$.name),
                  ),
                  ButtonSegment<Affordability>(
                    value: Affordability.$$$,
                    label: Text(Affordability.$$$.name),
                  ),
                  ButtonSegment<Affordability>(
                    value: Affordability.$$$$,
                    label: Text(Affordability.$$$$.name),
                  ),
                ],
                selected: <Affordability>{_reviewEntryEditLogic.affordability},
                onSelectionChanged: (Set<Affordability> newSelection) {
                  // By default there is only a single segment that can be
                  // selected at one time, so its value is always the first
                  // item in the selected set.
                  _reviewEntryEditLogic.affordability = newSelection.first;
                  _reviewEntryEditLogic.reviewEditModel = _reviewEntryEditLogic
                      .reviewEditModel
                      .copyWith(affordability: newSelection.first.name);
                  _affordabilityNotifier.value = newSelection.first;
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
