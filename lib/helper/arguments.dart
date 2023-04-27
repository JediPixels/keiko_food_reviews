import 'package:geolocator/geolocator.dart';
import 'package:keiko_food_reviews/helper/constants.dart';
import 'package:keiko_food_reviews/models/review_model.dart';

class ReviewEntryArguments {
  ReviewEntryArguments({required this.reviewMode, required this.reviewModel});

  final ReviewMode reviewMode;
  final ReviewModel reviewModel;
}

class ReviewEntryPhotoArguments {
  ReviewEntryPhotoArguments({required this.reviewModel});

  final ReviewModel reviewModel;
}

class LocationArguments {
  LocationArguments({required this.answer, required this.position});

  final bool answer;
  final Position? position;
}
