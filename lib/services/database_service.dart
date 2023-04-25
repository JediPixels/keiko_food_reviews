import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keiko_food_reviews/helper/constants.dart';
import 'package:keiko_food_reviews/models/review_model.dart';
import 'package:keiko_food_reviews/models/user_model.dart';
import 'package:keiko_food_reviews/services/storage_service.dart';

class DatabaseService {
  /// User Collection
  static Future<bool> addUser(UserModel userModel) async {
    // Use the set() to add new user in order to assign our own uid
    var result = await FirebaseFirestore.instance
        .collection(DatabaseCollections.users.name)
        .doc(userModel.uid)
        .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson())
        .set(userModel, SetOptions(merge: true))
        .then((_) => true)
        .onError((error, stackTrace) => false);
    return result;
  }

  static Future<UserModel> getUser(String uid) {
    return FirebaseFirestore.instance
        .collection('${DatabaseCollections.users.name}/$uid')
        .doc(uid)
        .withConverter(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson())
        .get()
        .then((documentSnapshot) => documentSnapshot.data()!)
        .onError((error, stackTrace) => Future.error('$error'));
  }

  static Future<bool> updateUser(UserModel userModel) {
    return FirebaseFirestore.instance
        .collection(DatabaseCollections.users.name)
        .doc(userModel.uid)
        .update(userModel.toJson())
        .then((_) => true)
        .onError((error, stackTrace) => false);
  }

  /// Review Collection
  static Future<bool> addReview({
    required ReviewModel reviewModel,
    XFile? file,
  }) async {
    // Check if a photo has been added
    if (reviewModel.photo.isNotEmpty) {
      // Upload new photo
      String downloadURL =
          await StorageService.uploadPhoto(uid: reviewModel.uid, file: file!);
      reviewModel = reviewModel.copyWith(photo: downloadURL);
    }

    return FirebaseFirestore.instance
        .collection(DatabaseCollections.usersData.name)
        .doc(reviewModel.uid)
        .collection(DatabaseCollections.reviews.name)
        .withConverter<ReviewModel>(
            fromFirestore: (snapshot, _) =>
                ReviewModel.fromJson(snapshot.data()!),
            toFirestore: (review, _) => review.toJson())
        .add(reviewModel)
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }

  static Future<bool> updateReview({
    required bool isPhotoChanged,
    required String originalPhotoUrl,
    required ReviewModel reviewEditModel,
    XFile? file,
  }) async {
    // Check if a photo changed and delete current uploaded photo
    if (reviewEditModel.photo.isEmpty &&
        originalPhotoUrl.isNotEmpty &&
        isPhotoChanged) {
      // Remove photo
      await StorageService.deletePhoto(photoPath: originalPhotoUrl);
    } else if (reviewEditModel.photo.isNotEmpty &&
        originalPhotoUrl.isNotEmpty &&
        isPhotoChanged) {
      // 1. Remove current photo
      await StorageService.deletePhoto(photoPath: originalPhotoUrl);
      // 2. Upload new photo
      String downloadURL = await StorageService.uploadPhoto(
          uid: reviewEditModel.uid, file: file!);
      reviewEditModel = reviewEditModel.copyWith(photo: downloadURL);
    } else if (reviewEditModel.photo.isNotEmpty &&
        originalPhotoUrl.isEmpty &&
        isPhotoChanged) {
      // No original photo, new photo picked
      String downloadURL = await StorageService.uploadPhoto(
        uid: reviewEditModel.uid,
        file: file!,
      );
      reviewEditModel = reviewEditModel.copyWith(photo: downloadURL);
    }

    return FirebaseFirestore.instance
        .collection(DatabaseCollections.usersData.name)
        .doc(reviewEditModel.uid)
        .collection(DatabaseCollections.reviews.name)
        .doc(reviewEditModel.documentId)
        .update(reviewEditModel.toJson())
        .then((_) => true)
        .onError((error, stackTrace) => false);
  }

  static Future<bool> deleteReview(ReviewModel reviewModel) {
    // Check if a photo is attached and delete it
    if (reviewModel.photo.isNotEmpty) {
      StorageService.deletePhoto(photoPath: reviewModel.photo);
    }

    return FirebaseFirestore.instance
        .collection(DatabaseCollections.usersData.name)
        .doc(reviewModel.uid)
        .collection(DatabaseCollections.reviews.name)
        .doc(reviewModel.documentId)
        .delete()
        .then((_) => true)
        .onError((error, stackTrace) => false);
  }

  static Stream<List<ReviewModel>> getReviewList(String uid) {
    return FirebaseFirestore.instance
        .collection(DatabaseCollections.usersData.name)
        .doc(uid)
        .collection(DatabaseCollections.reviews.name)
        .where('uid', isEqualTo: uid)
        .orderBy('reviewDate', descending: true)
        .withConverter<ReviewModel>(
            fromFirestore: (snapshot, _) {
              final reviewModel = ReviewModel.fromJson(snapshot.data()!);
              final reviewModelWithDocumentId =
                  reviewModel.copyWith(documentId: snapshot.id);
              return reviewModelWithDocumentId;
            },
            toFirestore: (review, _) => review.toJson())
        .snapshots()
        .map((QuerySnapshot<ReviewModel> snapshot) =>
            snapshot.docs.map((doc) => doc.data()).toList())
        .handleError((onError) => debugPrint('onError: $onError'));
  }

  static Stream<List<ReviewModel>> getReviewListPhotos(String uid) {
    return FirebaseFirestore.instance
        .collection(DatabaseCollections.usersData.name)
        .doc(uid)
        .collection(DatabaseCollections.reviews.name)
        .where('uid', isEqualTo: uid)
        .where('photo', isNotEqualTo: '')
        .withConverter<ReviewModel>(
            fromFirestore: (snapshot, _) {
              final reviewModel = ReviewModel.fromJson(snapshot.data()!);
              final reviewModelWithDocumentId =
                  reviewModel.copyWith(documentId: snapshot.id);
              return reviewModelWithDocumentId;
            },
            toFirestore: (review, _) => review.toJson())
        .snapshots()
        .map((QuerySnapshot<ReviewModel> snapshot) {
      List<ReviewModel> list = snapshot.docs.map((doc) => doc.data()).toList();
      list.sort((a, b) => b.reviewDate.compareTo(a.reviewDate));
      return list;
    }).handleError((onError) => debugPrint('onError: $onError'));

    // NOTE:
    // Currently there ares some restrictions with Firestore, inequality filter and sorting
    // Invalid query. You have a where filter with an inequality (<, <=, !=, not-in, >, or >=) on field 'photo'
    // and so you must also use 'photo' as your first argument to Query.orderBy(), but your first orderBy() is on field 'reviewDate' instead.
    // Any query that also contains a non equal to, you need to sort by that filter first
    // then you get a message to create the index. Click on the link and it will work.
    // https://firebase.google.com/docs/firestore/query-data/order-limit-data#limitations
    // https://firebase.google.com/docs/firestore/query-data/queries#query_limitations
    // https://stackoverflow.com/questions/68166318/the-initial-orderby-field-fieldpathid-true00-has-to-be-the-same
  }
}
