import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/helper/arguments.dart';
import 'package:keiko_food_reviews/models/review_model.dart';

class ReviewEntryPhotoZoom extends StatelessWidget {
  const ReviewEntryPhotoZoom({super.key});

  static const String route = '/review_entry_photo_zoom';

  @override
  Widget build(BuildContext context) {
    final ReviewEntryPhotoArguments reviewEntryPhotoArguments =
        ModalRoute.of(context)?.settings.arguments as ReviewEntryPhotoArguments;
    final ReviewModel reviewModel = reviewEntryPhotoArguments.reviewModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(reviewModel.title),
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.4),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          InteractiveViewer(
            child: Hero(
              tag: '${reviewModel.reviewDate}',
              // child: Image.network(
              //   reviewModel.photo,
              //   loadingBuilder: (
              //     BuildContext context,
              //     Widget image,
              //     ImageChunkEvent? loadingProgress,
              //   ) {
              //     if (loadingProgress == null) return image;
              //     return Center(
              //       child: CircularProgressIndicator(
              //         value: loadingProgress.expectedTotalBytes != null
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
            ),
          ),
        ],
      ),
    );
  }
}
