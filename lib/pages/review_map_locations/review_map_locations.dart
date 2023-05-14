import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/logic/review_map_locations_logic.dart';
import 'package:keiko_food_reviews/models/review_model.dart';
import 'package:keiko_food_reviews/pages/review_map_locations/review_map_locations_body.dart';
import 'package:keiko_food_reviews/widget/image_and_message.dart';

class ReviewMapLocations extends StatefulWidget {
  const ReviewMapLocations({Key? key}) : super(key: key);

  static const String route = '/review_map_locations';

  @override
  State<ReviewMapLocations> createState() => _ReviewMapLocationsState();
}

class _ReviewMapLocationsState extends State<ReviewMapLocations> {
  final ReviewMapLocationsLogic reviewMapLocationsLogic =
      ReviewMapLocationsLogic();

  @override
  void initState() {
    super.initState();
    reviewMapLocationsLogic.getReviewModelList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keiko Reviews Locations'),
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.4),
      ),
      extendBodyBehindAppBar: true,
      body: StreamBuilder<List<ReviewModel>>(
        initialData: const [],
        stream: reviewMapLocationsLogic.reviewModelList,
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
                  assetImageWithPath: 'assets/images/map_ping.png',
                  message: 'No Locations Available...',
                );
              }
              if (snapshot.data!.isNotEmpty) {
                List<ReviewModel> reviewList = snapshot.data!;
                return ReviewMapLocationsBody(reviewModelList: reviewList);
              } else {
                return const ImageAndMessage(
                  assetImageWithPath: 'assets/images/map_ping.png',
                  message: 'No Locations Available...',
                );
              }
            default:
              return const Center(child: Text('No Locations Available...'));
          }
        },
      ),
    );
  }
}
