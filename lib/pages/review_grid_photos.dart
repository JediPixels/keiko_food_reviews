import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/helper/arguments.dart';
import 'package:keiko_food_reviews/helper/themes.dart';
import 'package:keiko_food_reviews/logic/review_grid_photos_logic.dart';
import 'package:keiko_food_reviews/models/review_model.dart';
import 'package:keiko_food_reviews/pages/review_entry/review_entry_photo_zoom.dart';
import 'package:keiko_food_reviews/widget/image_and_message.dart';

class ReviewGridPhotos extends StatefulWidget {
  const ReviewGridPhotos({Key? key}) : super(key: key);

  static const String route = '/review_grid_photos';

  @override
  State<ReviewGridPhotos> createState() => _ReviewGridPhotosState();
}

class _ReviewGridPhotosState extends State<ReviewGridPhotos> {
  final ReviewGridPhotosLogic reviewGridPhotosLogic = ReviewGridPhotosLogic();

  @override
  void initState() {
    super.initState();
    reviewGridPhotosLogic.getReviewListPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keiko Gallery'),
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.4),
      ),
      extendBodyBehindAppBar: true,
      body: StreamBuilder<List<ReviewModel>>(
        initialData: const [],
        stream: reviewGridPhotosLogic.reviewModelList,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<ReviewModel>> snapshot,
        ) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              if (!snapshot.hasData) {
                return const ImageAndMessage(
                  assetImageWithPath: 'assets/images/placeholder_image.png',
                  message: 'No Photos Available...',
                );
              }
              if (snapshot.data!.isNotEmpty) {
                List<ReviewModel> reviewList = snapshot.data!;
                return GridView.builder(
                  itemCount: reviewList.length,
                  gridDelegate: kIsWeb
                      ? const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 184.0,
                        )
                      : const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    if (reviewList[index].photo.isNotEmpty) {
                      return InkWell(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Image
                            Hero(
                              tag: '${reviewList[index].reviewDate}',
                              // child: Image.network(
                              //   reviewList[index].photo,
                              //   fit: BoxFit.cover,
                              //   loadingBuilder: (
                              //     BuildContext context,
                              //     Widget image,
                              //     ImageChunkEvent? loadingProgress,
                              //   ) {
                              //     if (loadingProgress == null) return image;
                              //     return Center(
                              //       child: CircularProgressIndicator(
                              //         value:
                              //             loadingProgress.expectedTotalBytes !=
                              //                     null
                              //                 ? loadingProgress
                              //                         .cumulativeBytesLoaded /
                              //                     loadingProgress
                              //                         .expectedTotalBytes!
                              //                 : null,
                              //       ),
                              //     );
                              //   },
                              // ),
                              child: CachedNetworkImage(
                                imageUrl: reviewList[index].photo,
                                fit: BoxFit.cover,
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
                            ),
                            // Title Gradient Bar
                            Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.4),
                                      Theme.of(context).primaryColor,
                                    ],
                                    stops: const [0.4, 1.0],
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter,
                                  )),
                                  child: Text(
                                    reviewList[index].title,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: ThemeColors.titleBarText,
                                          fontWeight: FontWeight.bold,
                                          overflow: kIsWeb
                                              ? TextOverflow.ellipsis
                                              : TextOverflow.fade,
                                        ),
                                  ),
                                )),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ReviewEntryPhotoZoom.route,
                            arguments: ReviewEntryPhotoArguments(
                              reviewModel: reviewList[index],
                            ),
                          );
                        },
                      );
                    } else {
                      return Image.asset(
                        'assets/images/placeholder_image.png',
                        fit: BoxFit.cover,
                      );
                    }
                  },
                );
              } else {
                return const ImageAndMessage(
                  assetImageWithPath: 'assets/images/spaghetti.png',
                  message: 'No Photos Available...',
                );
              }
            default:
              return const Center(child: Text('No Photos Available...'));
          }
        },
      ),
    );
  }
}
