import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/helper/constants.dart';
import 'package:keiko_food_reviews/logic/review_entry_edit_logic.dart';

class ReviewEntryEditAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ReviewEntryEditAppBar({
    super.key,
    required ReviewEntryEditLogic reviewEntryEditLogic,
    required ValueNotifier<bool> showProgressIndicatorSaveNotifier,
  })  : _reviewEntryEditLogic = reviewEntryEditLogic,
        _showProgressIndicatorSaveNotifier = showProgressIndicatorSaveNotifier;

  final ReviewEntryEditLogic _reviewEntryEditLogic;
  final ValueNotifier<bool> _showProgressIndicatorSaveNotifier;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ValueListenableBuilder(
        valueListenable: _showProgressIndicatorSaveNotifier,
        builder: (BuildContext context, bool show, Widget? widget) {
          return Stack(
            children: [
              Visibility(
                visible: !_showProgressIndicatorSaveNotifier.value,
                child: Text(
                  _reviewEntryEditLogic.reviewMode == ReviewMode.add
                      ? 'Add Review'
                      : 'Edit Review',
                ),
              ),
              Visibility(
                visible: _showProgressIndicatorSaveNotifier.value,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        },
      ),
      leading: IconButton(
        tooltip: 'Cancel Editing Review',
        icon: const Icon(Icons.cancel_outlined),
        onPressed: () {
          _reviewEntryEditLogic
              .cancelEditingReview(context: context)
              .then((cancel) {
            if (cancel == true) {
              Navigator.of(context).pop();
            }
          });
        },
      ),
      actions: [
        _reviewEntryEditLogic.reviewMode == ReviewMode.edit
            ? IconButton(
                tooltip: 'Delete Review',
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _reviewEntryEditLogic
                      .deleteReview(context: context)
                      .then((delete) {
                    if (delete == true) {
                      Navigator.of(context).pop();
                    }
                  });
                },
              )
            : const SizedBox(),
        IconButton(
          tooltip: 'Save Review',
          icon: const Icon(Icons.save_outlined),
          onPressed: () {
            _showProgressIndicatorSaveNotifier.value = true;
            _reviewEntryEditLogic.saveReview().then((success) {
              if (success == true) {
                Navigator.of(context).pop();
              }
            }).whenComplete(
                () => _showProgressIndicatorSaveNotifier.value = false);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
