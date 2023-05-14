import 'package:keiko_food_reviews/models/review_model.dart';
import 'package:keiko_food_reviews/services/authentication_service.dart';
import 'package:keiko_food_reviews/services/database_service.dart';

class ReviewMapLocationsLogic {
  ReviewMapLocationsLogic() : _uid = AuthenticationService.getCurrentUserUid();

  final String _uid;
  late Stream<List<ReviewModel>> _reviewModelListStream;
  Stream<List<ReviewModel>> get reviewModelList => _reviewModelListStream;

  void getReviewModelList() {
    _reviewModelListStream = DatabaseService.getReviewList(_uid);
  }
}
