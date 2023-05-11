import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keiko_food_reviews/helper/constants.dart';
import 'package:keiko_food_reviews/helper/themes.dart';
import 'package:keiko_food_reviews/logic/review_entry_edit_logic.dart';

class ReviewEntryEditPhoto extends StatelessWidget {
  const ReviewEntryEditPhoto({
    super.key,
    required ReviewEntryEditLogic reviewEntryEditLogic,
    required ValueNotifier<String> photoNotifier,
  })  : _reviewEntryEditLogic = reviewEntryEditLogic,
        _photoNotifier = photoNotifier;

  final ReviewEntryEditLogic _reviewEntryEditLogic;
  final ValueNotifier<String> _photoNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _photoNotifier,
      builder: (
        BuildContext context,
        String photo,
        Widget? widget,
      ) {
        return _reviewEntryEditLogic.reviewEditModel.photo.isNotEmpty
            ? Stack(
                clipBehavior: Clip.none,
                children: [
                  Hero(
                    tag: '${_reviewEntryEditLogic.reviewEditModel.reviewDate}',
                    child: (_reviewEntryEditLogic.xFile != null && !kIsWeb)
                        ? Image.file(File(_reviewEntryEditLogic.xFile!.path))
                        // : Image.network(
                        //     _reviewEntryEditLogic.reviewEditModel.photo,
                        //     fit: BoxFit.fitWidth,
                        //     loadingBuilder: (
                        //       BuildContext context,
                        //       Widget image,
                        //       ImageChunkEvent? loadingProgress,
                        //     ) {
                        //       if (loadingProgress == null) return image;
                        //       return Center(
                        //         child: CircularProgressIndicator(
                        //           value: loadingProgress.expectedTotalBytes !=
                        //                   null
                        //               ? loadingProgress.cumulativeBytesLoaded /
                        //                   loadingProgress.expectedTotalBytes!
                        //               : null,
                        //         ),
                        //       );
                        //     },
                        //   ),
                        : CachedNetworkImage(
                            imageUrl:
                                _reviewEntryEditLogic.reviewEditModel.photo,
                            fit: BoxFit.fitWidth,
                            progressIndicatorBuilder: (
                              BuildContext context,
                              String url,
                              DownloadProgress downloadProgress,
                            ) =>
                                Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                              ),
                            ),
                            errorWidget: (
                              BuildContext context,
                              String url,
                              dynamic error,
                            ) =>
                                const Icon(Icons.error),
                          ),
                  ),
                  Positioned(
                    right: 8.0,
                    bottom: -28.0,
                    child: Card(
                      color: ThemeColors.washedOutWhite,
                      child: Row(
                        children: [
                          PopupMenuButton(
                            icon: Icon(
                              Icons.photo_camera,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            position: PopupMenuPosition.under,
                            tooltip: 'Replace Photo',
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem<MenuItemsPhoto>(
                                value: MenuItemsPhoto.camera,
                                child: Row(
                                  children: const [
                                    Icon(Icons.photo_camera),
                                    SizedBox(width: 8.0),
                                    Text('Take a Photo'),
                                  ],
                                ),
                              ),
                              PopupMenuItem<MenuItemsPhoto>(
                                value: MenuItemsPhoto.gallery,
                                child: Row(
                                  children: const [
                                    Icon(Icons.photo_album),
                                    SizedBox(width: 8.0),
                                    Text('Add from Photo Album'),
                                  ],
                                ),
                              ),
                            ],
                            onSelected: (selected) {
                              switch (selected) {
                                case MenuItemsPhoto.camera:
                                  _reviewEntryEditLogic
                                      .pickImage(
                                          imageSource: ImageSource.camera)
                                      .then((photo) =>
                                          _photoNotifier.value = photo);
                                  break;
                                case MenuItemsPhoto.gallery:
                                  _reviewEntryEditLogic
                                      .pickImage(
                                          imageSource: ImageSource.gallery)
                                      .then((photo) =>
                                          _photoNotifier.value = photo);
                                  break;
                              }
                            },
                          ),
                          const SizedBox(width: 8.0),
                          IconButton(
                            tooltip: 'Delete Photo',
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _reviewEntryEditLogic.reviewEditModel =
                                  _reviewEntryEditLogic.reviewEditModel
                                      .copyWith(photo: '');
                              _photoNotifier.value =
                                  _reviewEntryEditLogic.reviewEditModel.photo;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Hero(
                tag: _reviewEntryEditLogic.reviewMode == ReviewMode.add
                    ? 'addReviewEntry'
                    : '',
                child: PopupMenuButton(
                  tooltip: 'Menu',
                  icon: const Icon(Icons.add_a_photo_outlined),
                  position: PopupMenuPosition.under,
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<MenuItemsPhoto>(
                      value: MenuItemsPhoto.camera,
                      child: Row(
                        children: const [
                          Icon(Icons.photo_camera),
                          SizedBox(width: 8.0),
                          Text('Take a Photo'),
                        ],
                      ),
                    ),
                    PopupMenuItem<MenuItemsPhoto>(
                      value: MenuItemsPhoto.gallery,
                      child: Row(
                        children: const [
                          Icon(Icons.photo_album),
                          SizedBox(width: 8.0),
                          Text('Add from Photo Album'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (selected) {
                    switch (selected) {
                      case MenuItemsPhoto.camera:
                        _reviewEntryEditLogic
                            .pickImage(imageSource: ImageSource.camera)
                            .then((photo) => _photoNotifier.value = photo);
                        break;
                      case MenuItemsPhoto.gallery:
                        _reviewEntryEditLogic
                            .pickImage(imageSource: ImageSource.gallery)
                            .then((photo) => _photoNotifier.value = photo);
                        break;
                    }
                  },
                ),
              );
      },
    );
  }
}
