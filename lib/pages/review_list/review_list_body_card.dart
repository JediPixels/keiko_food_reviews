import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/helper/arguments.dart';
import 'package:keiko_food_reviews/helper/constants.dart';
import 'package:keiko_food_reviews/helper/dialogs.dart';
import 'package:keiko_food_reviews/helper/format_dates.dart';
import 'package:keiko_food_reviews/logic/review_list_logic.dart';
import 'package:keiko_food_reviews/models/review_model.dart';
import 'package:keiko_food_reviews/pages/review_entry/review_entry_view.dart';
import 'package:keiko_food_reviews/widget/muted_text.dart';
import 'package:keiko_food_reviews/widget/star_rating.dart';

class ReviewListBodyCard extends StatelessWidget {
  const ReviewListBodyCard({
    super.key,
    required this.reviewModel,
  });

  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${reviewModel.documentId}'),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: const Icon(Icons.delete),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        ReviewListLogic.deleteReview(reviewModel);
      },
      confirmDismiss: (DismissDirection direction) async {
        final confirmDelete = await Dialogs.showAlertDialog(
          context: context,
          title: 'Would you like to Delete Review?',
          contentDescription: reviewModel.title,
          noButtonTitle: 'No',
          yesButtonTile: 'Yes',
        );

        return confirmDelete;
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(8.0),
        elevation: 8.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8.0),
          ),
        ),
        child: InkWell(
          child: Column(
            children: [
              Hero(
                tag: '${reviewModel.reviewDate}',
                child: reviewModel.photo.isNotEmpty
                    ? AspectRatio(
                        aspectRatio: 3,
                        // child: Image.network(
                        //   reviewModel.photo,
                        //   fit: BoxFit.fitWidth,
                        //   height: 250.0,
                        //   loadingBuilder: (
                        //     BuildContext context,
                        //     Widget image,
                        //     ImageChunkEvent? loadingProgress,
                        //   ) {
                        //     if (loadingProgress == null) return image;
                        //     return Center(
                        //       child: CircularProgressIndicator(
                        //         value: loadingProgress.expectedTotalBytes !=
                        //                 null
                        //             ? loadingProgress.cumulativeBytesLoaded /
                        //                 loadingProgress.expectedTotalBytes!
                        //             : null,
                        //       ),
                        //     );
                        //   },
                        // ),
                        // Alternate way to load an image and cache it
                        child: CachedNetworkImage(
                          imageUrl: reviewModel.photo,
                          fit: BoxFit.fitWidth,
                          progressIndicatorBuilder: (
                            BuildContext context,
                            String url,
                            DownloadProgress downloadProgress,
                          ) =>
                              Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                          ),
                          errorWidget: (
                            BuildContext context,
                            String url,
                            dynamic error,
                          ) =>
                              const Icon(Icons.error),
                        ),
                      )
                    : const SizedBox(height: 0.0),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        reviewModel.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                        overflow:
                            kIsWeb ? TextOverflow.ellipsis : TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    StarRating(rating: reviewModel.rating),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MutedText(reviewModel.restaurant),
                        MutedText(reviewModel.affordability),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MutedText(reviewModel.category),
                        MutedText(
                          FormatDates.dateFormatShortMonthDayYear(
                            '${reviewModel.reviewDate}',
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Divider(),
                    Text(
                      reviewModel.review,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16.0),
                    Wrap(
                      children: [
                        const Icon(Icons.pin_drop),
                        MutedText('${reviewModel.locationPlacemark.locality} '),
                        MutedText(
                          '${reviewModel.locationPlacemark.administrativeArea} ',
                        ),
                        MutedText(reviewModel.locationPlacemark.country),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
                mouseCursor: SystemMouseCursors.click,
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              ReviewEntryView.route,
              arguments: ReviewEntryArguments(
                reviewMode: ReviewMode.readOnly,
                reviewModel: reviewModel,
              ),
            );
          },
        ),
      ),
    );
  }
}
