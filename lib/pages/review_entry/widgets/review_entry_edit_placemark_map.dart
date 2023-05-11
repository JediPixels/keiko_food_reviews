import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:keiko_food_reviews/helper/themes.dart';
import 'package:keiko_food_reviews/logic/review_entry_edit_logic.dart';
import 'package:keiko_food_reviews/widget/muted_text.dart';
import 'package:latlong2/latlong.dart';

class ReviewEntryEditPlacemarkMap extends StatelessWidget {
  const ReviewEntryEditPlacemarkMap({
    super.key,
    required ReviewEntryEditLogic reviewEntryEditLogic,
    required ValueNotifier<Position> positionNotifier,
    required MapController mapController,
    required ValueNotifier<bool> showProgressIndicatorLocationNotifier,
  })  : _reviewEntryEditLogic = reviewEntryEditLogic,
        _positionNotifier = positionNotifier,
        _mapController = mapController,
        _showProgressIndicatorLocationNotifier =
            showProgressIndicatorLocationNotifier;

  final ReviewEntryEditLogic _reviewEntryEditLogic;
  final ValueNotifier<Position> _positionNotifier;
  final MapController _mapController;
  final ValueNotifier<bool> _showProgressIndicatorLocationNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _positionNotifier,
      builder: (
        BuildContext context,
        Position position,
        Widget? widget,
      ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location Placemark
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                MutedText(
                  '${_reviewEntryEditLogic.reviewEditModel.locationPlacemark.street} ',
                ),
                MutedText(
                  '${_reviewEntryEditLogic.reviewEditModel.locationPlacemark.locality} ',
                ),
                MutedText(
                  '${_reviewEntryEditLogic.reviewEditModel.locationPlacemark.administrativeArea} ',
                ),
                MutedText(
                  '${_reviewEntryEditLogic.reviewEditModel.locationPlacemark.postalCode} ',
                ),
                MutedText(
                  _reviewEntryEditLogic
                      .reviewEditModel.locationPlacemark.country,
                ),
              ],
            ),
            // Container for Map, Progress Indicator, Menu Card
            SizedBox(
              height: 150.0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Map
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      enableMultiFingerGestureRace: false,
                      enableScrollWheel: false,
                      interactiveFlags: InteractiveFlag.none,
                      center: LatLng(
                        _reviewEntryEditLogic.reviewEditModel.location.latitude,
                        _reviewEntryEditLogic
                            .reviewEditModel.location.longitude,
                      ),
                      zoom: 16.0,
                      maxZoom: 18.0,
                      maxBounds: LatLngBounds(
                        LatLng(-90.0, -180.0),
                        LatLng(90.0, 180.0),
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: const ['map', 'b', 'c'],
                        userAgentPackageName: 'com.example.app',
                        tileProvider: NetworkTileProvider(),
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(
                              _reviewEntryEditLogic
                                  .reviewEditModel.location.latitude,
                              _reviewEntryEditLogic
                                  .reviewEditModel.location.longitude,
                            ),
                            width: 80.0,
                            height: 80.0,
                            builder: (BuildContext context) => const Icon(
                              Icons.location_pin,
                              color: ThemeColors.locationPin,
                              size: 40.0,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  // Progress Indicator
                  ValueListenableBuilder(
                    valueListenable: _showProgressIndicatorLocationNotifier,
                    builder: (
                      BuildContext context,
                      bool show,
                      Widget? widget,
                    ) {
                      return Visibility(
                        visible: _showProgressIndicatorLocationNotifier.value,
                        child: Positioned(
                          child: Container(
                            color: ThemeColors.washedOutBlack,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Menu Card
                  Positioned(
                    right: 8.0,
                    bottom: -28.0,
                    child: Card(
                      color: ThemeColors.washedOutWhite,
                      child: Row(
                        children: [
                          IconButton(
                            tooltip: 'Replace Location',
                            icon: const Icon(Icons.location_pin),
                            onPressed: () {
                              _showProgressIndicatorLocationNotifier.value =
                                  true;
                              _reviewEntryEditLogic
                                  .replaceLocation(context: context)
                                  .then((locationArguments) async {
                                if (locationArguments.answer == true) {
                                  _positionNotifier.value =
                                      locationArguments.position!;
                                  _mapController.move(
                                    LatLng(
                                      _reviewEntryEditLogic
                                          .reviewEditModel.location.latitude,
                                      _reviewEntryEditLogic
                                          .reviewEditModel.location.longitude,
                                    ),
                                    16.0,
                                  );
                                }
                              }).whenComplete(
                                () => _showProgressIndicatorLocationNotifier
                                    .value = false,
                              );
                            },
                          ),
                          const SizedBox(width: 8.0),
                          IconButton(
                            tooltip: 'Delete Location',
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _reviewEntryEditLogic
                                  .deleteLocation(context: context)
                                  .then((locationArguments) {
                                if (locationArguments.answer == true) {
                                  _positionNotifier.value =
                                      locationArguments.position!;
                                  _mapController.move(
                                    LatLng(0.0, 0.0),
                                    16.0,
                                  );
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
