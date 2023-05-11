import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:keiko_food_reviews/helper/arguments.dart';
import 'package:keiko_food_reviews/helper/constants.dart';
import 'package:keiko_food_reviews/helper/format_dates.dart';
import 'package:keiko_food_reviews/logic/review_entry_edit_logic.dart';
import 'package:keiko_food_reviews/pages/review_entry/widgets/review_entry_edit_appbar.dart';
import 'package:keiko_food_reviews/pages/review_entry/widgets/review_entry_edit_datepicker.dart';
import 'package:keiko_food_reviews/pages/review_entry/widgets/review_entry_edit_photo.dart';
import 'package:keiko_food_reviews/pages/review_entry/widgets/review_entry_edit_placemark_map.dart';
import 'package:keiko_food_reviews/pages/review_entry/widgets/review_entry_edit_rating_affordability.dart';
import 'package:keiko_food_reviews/pages/review_entry/widgets/review_entry_edit_textfields.dart';
import 'package:latlong2/latlong.dart';

class ReviewEntryEdit extends StatefulWidget {
  const ReviewEntryEdit({super.key});

  static const String route = '/review_entry_edit';

  @override
  State<ReviewEntryEdit> createState() => _ReviewEntryEditState();
}

class _ReviewEntryEditState extends State<ReviewEntryEdit> {
  late final ReviewEntryEditLogic _reviewEntryEditLogic;
  bool _runFirstTime = false;

  final TextEditingController _date = TextEditingController();
  final TextEditingController _restaurant = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _review = TextEditingController();

  // Only refresh the section effected
  late final ValueNotifier<String> _photoNotifier;
  late final ValueNotifier<String> _reviewDateNotifier;
  late final ValueNotifier<double> _ratingNotifier;
  late final ValueNotifier<Affordability> _affordabilityNotifier;
  late final ValueNotifier<Position> _positionNotifier;
  late final ValueNotifier<bool> _showProgressIndicatorSaveNotifier;
  late final ValueNotifier<bool> _showProgressIndicatorLocationNotifier;

  final MapController _mapController = MapController();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // Check if run at first time has been initialized and only initialize once
    if (_runFirstTime == false) {
      _runFirstTime = true;

      // Retrieve ModalRoute Arguments
      final ReviewEntryArguments reviewEntryArguments =
          ModalRoute.of(context)?.settings.arguments as ReviewEntryArguments;

      // Initialize defaults depending if Add New or Edit existing Review
      _reviewEntryEditLogic = ReviewEntryEditLogic(
        reviewOriginalModel: reviewEntryArguments.reviewModel,
      );
      _reviewEntryEditLogic.reviewMode = reviewEntryArguments.reviewMode;
      _reviewEntryEditLogic.reviewEditModel =
          _reviewEntryEditLogic.reviewOriginalModel.copyWith(
        documentId: _reviewEntryEditLogic.reviewMode == ReviewMode.edit
            ? _reviewEntryEditLogic.reviewOriginalModel.documentId
            : '',
      );
      _reviewEntryEditLogic.affordability = Affordability.values.firstWhere(
        (element) =>
            element.name == _reviewEntryEditLogic.reviewEditModel.affordability,
      );

      // Initialize TextEditingControllers
      _date.text = FormatDates.dateFormatShortMonthDayYear(
        '${_reviewEntryEditLogic.reviewEditModel.reviewDate}',
      );
      _restaurant.text = _reviewEntryEditLogic.reviewEditModel.restaurant;
      _title.text = _reviewEntryEditLogic.reviewEditModel.title;
      _category.text = _reviewEntryEditLogic.reviewEditModel.category;
      _review.text = _reviewEntryEditLogic.reviewEditModel.review;

      // Initialize ValueNotifiers
      _photoNotifier =
          ValueNotifier<String>(_reviewEntryEditLogic.reviewEditModel.photo);
      _reviewDateNotifier = ValueNotifier<String>(_date.text);
      _ratingNotifier = ValueNotifier<double>(
        _reviewEntryEditLogic.reviewEditModel.rating,
      );
      _affordabilityNotifier = ValueNotifier<Affordability>(
        Affordability.values.firstWhere(
          (element) =>
              element.name ==
              _reviewEntryEditLogic.reviewEditModel.affordability,
        ),
      );
      _showProgressIndicatorSaveNotifier = ValueNotifier<bool>(false);
      _showProgressIndicatorLocationNotifier = ValueNotifier<bool>(false);

      // Location Position
      _positionNotifier = _reviewEntryEditLogic.initializePositionDefaults();
      if (_reviewEntryEditLogic.reviewMode == ReviewMode.add) {
        _showProgressIndicatorLocationNotifier.value = true;
        _positionNotifier.value = await _reviewEntryEditLogic.getLocation();
        _mapController.move(
          LatLng(
            _reviewEntryEditLogic.reviewEditModel.location.latitude,
            _reviewEntryEditLogic.reviewEditModel.location.longitude,
          ),
          16.0,
        );
        _showProgressIndicatorLocationNotifier.value = false;
      }
    }
  }

  @override
  void dispose() {
    _date.dispose();
    _restaurant.dispose();
    _title.dispose();
    _category.dispose();
    _review.dispose();
    _photoNotifier.dispose();
    _reviewDateNotifier.dispose();
    _ratingNotifier.dispose();
    _affordabilityNotifier.dispose();
    _positionNotifier.dispose();
    _showProgressIndicatorSaveNotifier.dispose();
    _showProgressIndicatorLocationNotifier.dispose();
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _reviewEntryEditLogic
            .cancelEditingReview(context: context)
            .then((cancel) {
          if (cancel == true) {
            Navigator.of(context).pop();
            return true;
          } else {
            return false;
          }
        });
      },
      child: Scaffold(
        appBar: ReviewEntryEditAppBar(
          reviewEntryEditLogic: _reviewEntryEditLogic,
          showProgressIndicatorSaveNotifier: _showProgressIndicatorSaveNotifier,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ReviewEntryEditPhoto(
                  reviewEntryEditLogic: _reviewEntryEditLogic,
                  photoNotifier: _photoNotifier,
                ),
                // Date Picker, Entry Fields, add padding all around...
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date Picker
                      ReviewEntryEditDatePicker(
                        reviewEntryEditLogic: _reviewEntryEditLogic,
                        date: _date,
                        reviewDateNotifier: _reviewDateNotifier,
                      ),
                      const SizedBox(height: 16.0),
                      ReviewEntryEditRatingAffordability(
                        reviewEntryEditLogic: _reviewEntryEditLogic,
                        ratingNotifier: _ratingNotifier,
                        affordabilityNotifier: _affordabilityNotifier,
                      ),
                      ReviewEntryEditTextFields(
                        reviewEntryEditLogic: _reviewEntryEditLogic,
                        restaurant: _restaurant,
                        title: _title,
                        category: _category,
                        review: _review,
                      ),
                      const SizedBox(height: 24.0),
                      ReviewEntryEditPlacemarkMap(
                        reviewEntryEditLogic: _reviewEntryEditLogic,
                        positionNotifier: _positionNotifier,
                        mapController: _mapController,
                        showProgressIndicatorLocationNotifier:
                            _showProgressIndicatorLocationNotifier,
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
