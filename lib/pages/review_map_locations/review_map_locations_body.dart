import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:keiko_food_reviews/helper/themes.dart';
import 'package:keiko_food_reviews/models/review_model.dart';
import 'package:latlong2/latlong.dart';

class ReviewMapLocationsBody extends StatelessWidget {
  const ReviewMapLocationsBody({
    super.key,
    required this.reviewModelList,
  });

  final List<ReviewModel> reviewModelList;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        zoom: 18.0,
        maxZoom: 18.0,
        boundsOptions: const FitBoundsOptions(forceIntegerZoomLevel: true),
        bounds: LatLngBounds.fromPoints(
          [
            ...reviewModelList.map(
              (review) => LatLng(
                review.location.latitude,
                review.location.longitude,
              ),
            ),
          ],
        ),
        maxBounds: LatLngBounds(
          const LatLng(-90.0, -180.0),
          const LatLng(90.0, 180.0),
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['map', 'b', 'c'],
          userAgentPackageName: 'com.example.app',
          tileProvider: NetworkTileProvider(),
        ),
        MarkerLayer(
          markers: [
            ...reviewModelList.map(
              (marker) => Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(
                  marker.location.latitude,
                  marker.location.longitude,
                ),
                builder: (BuildContext context) => const Icon(
                  Icons.location_pin,
                  color: ThemeColors.locationPin,
                  size: 40.0,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
