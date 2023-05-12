import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/logic/review_entry_edit_logic.dart';

class ReviewEntryEditTextFields extends StatelessWidget {
  const ReviewEntryEditTextFields({
    super.key,
    required ReviewEntryEditLogic reviewEntryEditLogic,
    required TextEditingController restaurant,
    required TextEditingController title,
    required TextEditingController category,
    required TextEditingController review,
  })  : _reviewEntryEditLogic = reviewEntryEditLogic,
        _restaurant = restaurant,
        _title = title,
        _category = category,
        _review = review;

  final ReviewEntryEditLogic _reviewEntryEditLogic;
  final TextEditingController _restaurant;
  final TextEditingController _title;
  final TextEditingController _category;
  final TextEditingController _review;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _restaurant,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(hintText: 'Restaurant'),
          onTapOutside: (PointerDownEvent pointerDownEvent) {
            FocusScope.of(context).unfocus();
          },
          onChanged: (value) {
            _reviewEntryEditLogic.reviewEditModel = _reviewEntryEditLogic
                .reviewEditModel
                .copyWith(restaurant: value);
          },
        ),
        TextField(
          controller: _title,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(hintText: 'Title'),
          onTapOutside: (PointerDownEvent pointerDownEvent) {
            FocusScope.of(context).unfocus();
          },
          onChanged: (value) {
            _reviewEntryEditLogic.reviewEditModel =
                _reviewEntryEditLogic.reviewEditModel.copyWith(title: value);
          },
        ),
        TextField(
          controller: _category,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(hintText: 'Category'),
          onTapOutside: (PointerDownEvent pointerDownEvent) {
            FocusScope.of(context).unfocus();
          },
          onChanged: (value) {
            _reviewEntryEditLogic.reviewEditModel =
                _reviewEntryEditLogic.reviewEditModel.copyWith(category: value);
          },
        ),
        TextField(
          controller: _review,
          textInputAction: TextInputAction.newline,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(hintText: 'Review'),
          onTapOutside: (PointerDownEvent pointerDownEvent) {
            FocusScope.of(context).unfocus();
          },
          onChanged: (value) {
            _reviewEntryEditLogic.reviewEditModel =
                _reviewEntryEditLogic.reviewEditModel.copyWith(review: value);
          },
        ),
      ],
    );
  }
}
