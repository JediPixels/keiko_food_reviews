class ReviewModel {
  ReviewModel({
    this.documentId,
    required this.uid,
    required this.reviewDate,
    required this.affordability,
    required this.rating,
    required this.category,
    required this.restaurant,
    required this.title,
    required this.review,
    required this.photo,
    required this.location,
    required this.locationPlacemark,
  });

  // documentId is optional because it's only used to track the document id
  String? documentId;
  String uid;
  DateTime reviewDate;
  String affordability;
  double rating;
  String category;
  String restaurant;
  String title;
  String review;
  String photo;
  Location location;
  LocationPlacemark locationPlacemark;

  ReviewModel copyWith({
    String? documentId,
    String? uid,
    DateTime? reviewDate,
    String? affordability,
    double? rating,
    String? category,
    String? restaurant,
    String? title,
    String? review,
    String? photo,
    Location? location,
    LocationPlacemark? locationPlacemark,
  }) =>
      ReviewModel(
        documentId: documentId ?? this.documentId,
        uid: uid ?? this.uid,
        reviewDate: reviewDate ?? this.reviewDate,
        affordability: affordability ?? this.affordability,
        rating: rating ?? this.rating,
        category: category ?? this.category,
        restaurant: restaurant ?? this.restaurant,
        title: title ?? this.title,
        review: review ?? this.review,
        photo: photo ?? this.photo,
        location: location ?? this.location,
        locationPlacemark: locationPlacemark ?? this.locationPlacemark,
      );

  // Equality Check -> ReviewModel1 == ReviewModel2
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewModel &&
          reviewDate == other.reviewDate &&
          affordability == other.affordability &&
          rating == other.rating &&
          category == other.category &&
          restaurant == other.restaurant &&
          title == other.title &&
          review == other.review &&
          photo == other.photo &&
          location == other.location &&
          locationPlacemark == other.locationPlacemark;

  @override
  int get hashCode =>
      reviewDate.hashCode ^
      affordability.hashCode ^
      rating.hashCode ^
      category.hashCode ^
      restaurant.hashCode ^
      title.hashCode ^
      review.hashCode ^
      photo.hashCode ^
      location.hashCode ^
      locationPlacemark.hashCode;

  factory ReviewModel.addNewReviewWithDefaultValues({required String uid}) {
    return ReviewModel(
      // documentId: '',
      uid: uid,
      reviewDate: DateTime.now(),
      affordability: '\$',
      rating: 0,
      category: '',
      restaurant: '',
      title: '',
      review: '',
      photo: '',
      location: Location(latitude: 0, longitude: 0),
      locationPlacemark: LocationPlacemark(
        name: '',
        street: '',
        isoCountryCode: '',
        country: '',
        postalCode: '',
        administrativeArea: '',
        subAdministrativeArea: '',
        locality: '',
        subLocality: '',
        thoroughfare: '',
        subThoroughfare: '',
      ),
    );
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        //documentId: json["documentID"],
        uid: json["uid"],
        reviewDate: DateTime.parse(json["reviewDate"]),
        affordability: json["affordability"],
        rating: json["rating"]?.toDouble(),
        category: json["category"],
        restaurant: json["restaurant"],
        title: json["title"],
        review: json["review"],
        photo: json["photo"],
        location: Location.fromJson(json["location"]),
        locationPlacemark:
            LocationPlacemark.fromJson(json["locationPlacemark"]),
      );

  Map<String, dynamic> toJson() => {
        //"documentID": documentId,
        "uid": uid,
        "reviewDate": reviewDate.toIso8601String(),
        "affordability": affordability,
        "rating": rating,
        "category": category,
        "restaurant": restaurant,
        "title": title,
        "review": review,
        "photo": photo,
        "location": location.toJson(),
        "locationPlacemark": locationPlacemark.toJson(),
      };
}

class Location {
  Location({
    required this.latitude,
    required this.longitude,
  });

  double latitude;
  double longitude;

  Location copyWith({
    double? latitude,
    double? longitude,
  }) =>
      Location(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class LocationPlacemark {
  LocationPlacemark({
    required this.name,
    required this.street,
    required this.isoCountryCode,
    required this.country,
    required this.postalCode,
    required this.administrativeArea,
    required this.subAdministrativeArea,
    required this.locality,
    required this.subLocality,
    required this.thoroughfare,
    required this.subThoroughfare,
  });

  String name;
  String street;
  String isoCountryCode;
  String country;
  String postalCode;
  String administrativeArea;
  String subAdministrativeArea;
  String locality;
  String subLocality;
  String thoroughfare;
  String subThoroughfare;

  LocationPlacemark copyWith({
    String? name,
    String? street,
    String? isoCountryCode,
    String? country,
    String? postalCode,
    String? administrativeArea,
    String? subAdministrativeArea,
    String? locality,
    String? subLocality,
    String? thoroughfare,
    String? subThoroughfare,
  }) =>
      LocationPlacemark(
        name: name ?? this.name,
        street: street ?? this.street,
        isoCountryCode: isoCountryCode ?? this.isoCountryCode,
        country: country ?? this.country,
        postalCode: postalCode ?? this.postalCode,
        administrativeArea: administrativeArea ?? this.administrativeArea,
        subAdministrativeArea:
            subAdministrativeArea ?? this.subAdministrativeArea,
        locality: locality ?? this.locality,
        subLocality: subLocality ?? this.subLocality,
        thoroughfare: thoroughfare ?? this.thoroughfare,
        subThoroughfare: subThoroughfare ?? this.subThoroughfare,
      );

  factory LocationPlacemark.fromJson(Map<String, dynamic> json) =>
      LocationPlacemark(
        name: json["name"],
        street: json["street"],
        isoCountryCode: json["isoCountryCode"],
        country: json["country"],
        postalCode: json["postalCode"],
        administrativeArea: json["administrativeArea"],
        subAdministrativeArea: json["subAdministrativeArea"],
        locality: json["locality"],
        subLocality: json["subLocality"],
        thoroughfare: json["thoroughfare"],
        subThoroughfare: json["subThoroughfare"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "street": street,
        "isoCountryCode": isoCountryCode,
        "country": country,
        "postalCode": postalCode,
        "administrativeArea": administrativeArea,
        "subAdministrativeArea": subAdministrativeArea,
        "locality": locality,
        "subLocality": subLocality,
        "thoroughfare": thoroughfare,
        "subThoroughfare": subThoroughfare,
      };
}
