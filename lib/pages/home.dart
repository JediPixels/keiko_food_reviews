import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/pages/review_grid_photos.dart';
import 'package:keiko_food_reviews/pages/review_list/review_list.dart';
import 'package:keiko_food_reviews/pages/review_map_locations/review_map_locations.dart';
import 'package:keiko_food_reviews/widget/responsive_layout_builder.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const String route = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPageIndex = 0;
  final _bodySelectedPage = <Widget>[
    const ReviewList(),
    const ReviewGridPhotos(),
    const ReviewMapLocations(),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      mobile: Scaffold(
        body: _bodySelectedPage[_currentPageIndex],
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.reviews), label: 'Reviews'),
            NavigationDestination(icon: Icon(Icons.photo_library), label: 'Photos'),
            NavigationDestination(icon: Icon(Icons.location_pin), label: 'Locations'),
          ],
          selectedIndex: _currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
        ),
      ),
      webDesktopTablet: Scaffold(
        body: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondaryContainer,
                  ]
                )
              ),
              child: NavigationRail(
                backgroundColor: Colors.transparent,
                labelType: NavigationRailLabelType.all,
                leading: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Image.asset(
                    'assets/images/crown.png',
                    width: 48.0,
                    fit: BoxFit.cover,
                  ),
                ),
                destinations: const [
                  NavigationRailDestination(icon: Icon(Icons.reviews), label: Text('Reviews')),
                  NavigationRailDestination(icon: Icon(Icons.photo_library), label: Text('Photos')),
                  NavigationRailDestination(icon: Icon(Icons.location_pin), label: Text('Locations')),
                ],
                selectedIndex: _currentPageIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
              ),
            ),
            Expanded(child: _bodySelectedPage[_currentPageIndex]),
          ],
        ),
      ),
    );
  }
}
