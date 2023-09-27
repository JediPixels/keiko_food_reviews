import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keiko_food_reviews/helper/arguments.dart';
import 'package:keiko_food_reviews/helper/constants.dart';
import 'package:keiko_food_reviews/helper/dialogs.dart';
import 'package:keiko_food_reviews/helper/format_dates.dart';
import 'package:keiko_food_reviews/models/review_model.dart';
import 'package:keiko_food_reviews/services/database_service.dart';
import 'package:keiko_food_reviews/services/location_service.dart';

class ReviewEntryEditLogic {
  ReviewEntryEditLogic({required this.reviewOriginalModel});

  // Public
  final ReviewModel reviewOriginalModel;
  late ReviewModel reviewEditModel;
  late ReviewMode reviewMode;
  late Affordability affordability;
  XFile? xFile;

  ValueNotifier<Position> initializePositionDefaults() {
    return ValueNotifier<Position>(
      Position(
        longitude: 0.0,
        latitude: 0.0,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
      ),
    );
  }

  Future<Position> getLocation() async {
    Position position = await LocationService.getLocation();
    if (kIsWeb) {
      Address address = await LocationService.getReverseGeocodingWeb(position);
      setLocationAndAddressWeb(position: position, address: address);
    } else {
      Placemark placemark =
          await LocationService.getReverseGeocodingMobile(position);
      setLocationAndAddressMobile(position: position, placemark: placemark);
    }
    return position;
  }

  Future<LocationArguments> replaceLocation({required BuildContext context}) {
    return Dialogs.showAlertDialog(
      context: context,
      title: 'Change Location',
      contentDescription: 'Would you like to retrieve a new Location?',
      noButtonTitle: 'No',
      yesButtonTile: 'Yes',
    ).then((answer) async {
      if (answer == true) {
        Position position = await getLocation();
        return LocationArguments(answer: true, position: position);
      } else {
        return LocationArguments(answer: false);
      }
    });
  }

  Future<LocationArguments> deleteLocation({required BuildContext context}) {
    return Dialogs.showAlertDialog(
      context: context,
      title: 'Remove Location',
      contentDescription: 'Would you like to remove Location?',
      noButtonTitle: 'No',
      yesButtonTile: 'Yes',
    ).then((answer) {
      if (answer == true) {
        reviewEditModel = reviewEditModel.copyWith(
          location: reviewEditModel.location.copyWith(
            latitude: 0.0,
            longitude: 0.0,
          ),
          locationPlacemark: reviewEditModel.locationPlacemark.copyWith(
            administrativeArea: '',
            country: '',
            isoCountryCode: '',
            locality: '',
            name: '',
            postalCode: '',
            street: '',
            subAdministrativeArea: '',
            subLocality: '',
            subThoroughfare: '',
          ),
        );
        Position position = Position(
          longitude: 0.0,
          latitude: 0.0,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0.0,
          headingAccuracy: 0.0,
        );
        return LocationArguments(answer: true, position: position);
      } else {
        return LocationArguments(answer: false);
      }
    });
  }

  // Called by the getLocation() method
  void setLocationAndAddressWeb({
    required Position position,
    required Address address,
  }) {
    reviewEditModel = reviewEditModel.copyWith(
      location: reviewEditModel.location.copyWith(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
      locationPlacemark: reviewEditModel.locationPlacemark.copyWith(
        administrativeArea: address.city,
        country: address.countryName,
        isoCountryCode: address.countryCode,
        name: address.streetNumber == null ? '' : '${address.streetNumber}',
        postalCode: address.postal,
        street: address.streetAddress,
      ),
    );
  }

  void setLocationAndAddressMobile({
    required Position position,
    required Placemark placemark,
  }) {
    reviewEditModel = reviewEditModel.copyWith(
      location: reviewEditModel.location.copyWith(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
      locationPlacemark: reviewEditModel.locationPlacemark.copyWith(
        administrativeArea: placemark.administrativeArea,
        country: placemark.country,
        isoCountryCode: placemark.isoCountryCode,
        locality: placemark.locality,
        name: placemark.name,
        postalCode: placemark.postalCode,
        street: placemark.street,
        subAdministrativeArea: placemark.subAdministrativeArea,
        subLocality: placemark.subLocality,
        subThoroughfare: placemark.subThoroughfare,
      ),
    );
  }

  bool checkIfDataChanged() {
    if (reviewOriginalModel == reviewEditModel) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> saveReview() {
    // Check if user changed photo when editing
    bool isPhotoChanged =
        reviewOriginalModel.photo != reviewEditModel.photo ? true : false;

    if (reviewMode == ReviewMode.edit) {
      // Check if any changes happened
      if (checkIfDataChanged()) {
        return DatabaseService.updateReview(
          isPhotoChanged: isPhotoChanged,
          originalPhotoUrl: reviewOriginalModel.photo,
          reviewEditModel: reviewEditModel,
          file: xFile,
        ).then((value) => true).onError((error, stackTrace) => false);
      } else {
        // Data did not change, close page
        return Future.value(true);
      }
    } else if (reviewMode == ReviewMode.add) {
      return DatabaseService.addReview(
        reviewModel: reviewEditModel,
        file: xFile,
      ).then((value) => true).onError((error, stackTrace) => false);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> cancelEditingReview({required BuildContext context}) {
    // Check if any changes were made
    // If no changes have been made, allow to close the page
    if (reviewOriginalModel == reviewEditModel) {
      return Future.value(true);
    }

    return Dialogs.showAlertDialog(
      context: context,
      title: 'Cancel Saving?',
      contentDescription: 'Would you like to Cancel Saving?',
      noButtonTitle: 'No',
      yesButtonTile: 'Yes',
    ).then((answer) => answer == true ? true : false);
  }

  Future<bool> deleteReview({required BuildContext context}) {
    return Dialogs.showAlertDialog(
      context: context,
      title: 'Would you like to Delete Review?',
      contentDescription: reviewEditModel.title,
      noButtonTitle: 'No',
      yesButtonTile: 'Yes',
    ).then((answer) {
      if (answer == true) {
        return DatabaseService.deleteReview(reviewEditModel)
            .then((value) => true)
            .onError((error, stackTrace) => false);
      } else {
        return false;
      }
    });
  }

  Future<String> selectDate({required BuildContext context}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      keyboardType: TextInputType.datetime,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: reviewEditModel.reviewDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      final DateTime selectedDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        reviewEditModel.reviewDate.hour,
        reviewEditModel.reviewDate.minute,
        reviewEditModel.reviewDate.second,
        reviewEditModel.reviewDate.millisecond,
        reviewEditModel.reviewDate.microsecond,
      );
      reviewEditModel = reviewEditModel.copyWith(reviewDate: selectedDate);
      return FormatDates.dateFormatShortMonthDayYear(
        '${reviewEditModel.reviewDate}',
      );
    } else {
      return '';
    }
  }

  Future<String> pickImage({
    ImageSource imageSource = ImageSource.gallery,
  }) async {
    final ImagePicker imagePicker = ImagePicker();
    xFile = await imagePicker.pickImage(source: imageSource);

    // Update the page with the newly picked image, it will be saved later
    reviewEditModel = reviewEditModel.copyWith(photo: xFile?.path);
    return reviewEditModel.photo;
  }
}
