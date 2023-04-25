import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:keiko_food_reviews/helper/location_api_keys.dart';

class LocationService {
  static Future<Position> getLocation() async {
    Position currentPosition = await _determinePosition();
    return currentPosition;
  }

  static Future<Address> getReverseGeocodingWeb(Position position) async {
    // GeoCode for Web
    GeoCode geoCode = GeoCode(apiKey: LocationApiKeys.geoCodeApiKey);
    final address = await geoCode.reverseGeocoding(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    return address;
  }

  static Future<Placemark> getReverseGeocodingMobile(Position position) async {
    // Geolocation for Mobile
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    return place;
  }

  static Future<Position> _determinePosition() async {
    // Test if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      return Future.error('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time we could ask for permissions again
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      return Future.error('''Location permissions are permanently denied,
      we cannot request permissions''');
    }

    // Permissions are granted, we can access location on the device
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
