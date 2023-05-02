import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/helper/constants.dart';
import 'package:keiko_food_reviews/models/review_model.dart';
import 'package:keiko_food_reviews/pages/review_list/review_list_body_card.dart';
import 'package:keiko_food_reviews/widget/image_and_message.dart';

class ReviewListBody extends StatelessWidget {
  const ReviewListBody({
    super.key,
    required this.reviewModelList,
  });

  final List<ReviewModel> reviewModelList;

  @override
  Widget build(BuildContext context) {
    final double maxCrossAxisExtent = ResponsiveSizes.webDesktopTablet.value;
    final double mainAxisExtent = maxCrossAxisExtent * 0.75;

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: ImageAndMessage(
            topPadding: 24.0,
            iconHeight: 48.0,
            assetImageWithPath: 'assets/images/lobster.png',
          ),
        ),
        kIsWeb
            ? SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      ReviewListBodyCard(reviewModel: reviewModelList[index]),
                  childCount: reviewModelList.length,
                ),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: maxCrossAxisExtent,
                  mainAxisExtent: mainAxisExtent,
                ),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      ReviewListBodyCard(reviewModel: reviewModelList[index]),
                  childCount: reviewModelList.length,
                ),
              )
      ],
    );
  }
}
