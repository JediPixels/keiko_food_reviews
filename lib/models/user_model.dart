class UserModel {
  UserModel({
    required this.uid,
    required this.createdDate,
    required this.email,
    required this.emailVerified,
    required this.phoneNumber,
    required this.displayName,
    required this.photoUrl,
    required this.providerId,
  });

  final String uid;
  final DateTime createdDate;
  final String email;
  final bool emailVerified;
  final String phoneNumber;
  final String displayName;
  final String photoUrl;
  final String providerId;

  factory UserModel.initializeNewUserWithDefaultValues({
    required String uid,
    String email = '',
    String providerId = 'password'}) {

    return UserModel(
      uid: uid,
      createdDate: DateTime.now(),
      email: email,
      emailVerified: false,
      phoneNumber: '',
      displayName: '',
      photoUrl: '',
      providerId: providerId
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json["uid"],
    createdDate: DateTime.parse(json["createdDate"]),
    email: json["email"],
    emailVerified: json["emailVerified"],
    phoneNumber: json["phoneNumber"],
    displayName: json["displayName"],
    photoUrl: json["photoURL"],
    providerId: json["providerId"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "createdDate": createdDate.toIso8601String(),
    "email": email,
    "emailVerified": emailVerified,
    "phoneNumber": phoneNumber,
    "displayName": displayName,
    "photoURL": photoUrl,
    "providerId": providerId,
  };
}

// JSON
/*
{
  "uid": "abc122",
  "createdDate": "2030-01-01T15:00:00",
  "email": "",
  "emailVerified": false,
  "phoneNumber": "",
  "displayName": "",
  "photoURL": "",
  "providerId": "password"
}
*/