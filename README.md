# Keiko Food & Travel Reviews
### Flutter App for iOS, Android and Web

|![/.readme_assets/mobile.jpg](/.readme_assets/mobile.jpg)|![/.readme_assets/web.jpg](/.readme_assets/web.jpg)|  
|--|--|

### PROBLEM:
You have been hired by Bruno, aka, Hair Force One, yep that's his nickname since he always has the perfect hair and burly beard. Bruno has a consulting company that focuses on custom build mobile applications for iOS and Android. Bruno's new client is Keiko Corp., an Italian food and travel company. Their employees are paid to travel and sample food around the globe. Their job is to share their experiences for Keiko Food and Travel channel. How cool is that?

So, what are the requirements? The mobile application needs to record each journal entry with a review description, attach photo's, record location and sync data via Cloud. Keiko Corp. needs to release both iOS and Android apps and updates at the same time. They need the User Interface and User Experience to be exactly the same to show the company's branding. Bruno's company is used to building iOS apps with two different code bases, one for iOS and one for Android. This causes a big problem because of the development timeline constraints and additional development cost of assigning at least two developers, one for each project.

### SOLUTION:
Flutter framework, Dart Language, Firebase Authentication, Firestore Database, Cloud Storage and Location Services to the rescue!!! With Flutter, you'll be able to build beautiful, natively compiled, multi-platform applications from a single codebase. You'll be able to build applications for mobile, web, desktop and embedded apps. The Flutter framework is used by the biggest companies in the world, Google, eBay, BMW, Toyota, Groupon, MGM Resorts, Philips hue and so on.

Now that we have chosen the development path, how do we create new users, authenticate them, separate data by each user, and sync the data via Cloud Worldwide? How do we attach photos to each journal entry? How do we obtain the location for each entry? You'll use Firebase Authentication to create new users, validate them, and authenticate login by user. You'll create a fully scalable Firestore database to handle storing data separated by users.  To store each photo you'll use Cloud Storage, also separated by users. To record the user's location at time of review, you'll use Location Services to obtain the GPS location, and Reverse Geocoding to retrieve the street address, city, state, zip, country. All of our requirements are fulfilled by using Flutter, Dart, Firebase Authentication, Firestore Database, Cloud Storage, and Location Services.

<br/>  

### WHAT YOU’LL LEARN


- Build beautifully designed real-world enterprise-level mobile application for iOS, Android, and Web
- Learn UI/UX techniques to wow the user’s experience and keep the company’s branding consistent between platforms
- Use the latest cross-platform Flutter framework and Dart language to create pixel perfect UI designs and adaptivity
- Learn Firebase Authentication to create end-to-end identity solution to create, validate and authenticate users
- Learn Cloud Firestore to build serverless, secure Database that sync data between online and offline devices
- Learn Cloud Storage to store and serve user generated content like photos
- Learn how to sync data live between multiple devices allowing the user to switch between mobile and web
- Learn how to restore user’s data on a new device
- Learn to use Location Services to obtain GPS location and Reverse Geocoding to retrieve address
- Lear to use Custom Clippers to create beautiful looking app bars
- View and Zoom photos
- Create reusable widgets
- Use Layout Builder to create a responsive layout for mobile and web
- Separate concerns between UI, state, business logic, and services
- Learn how to use State Management without using third party libraries
- Learn how to create reactive screens to refresh content
- Learn how to apply beautiful animations to convey actions
- Every feature and change made are fully released at the same time for both iOS, Android, and Web, one codebase to rule them all
- Reliable, Scalable, Secure
- Version Control Integration - GitHub
- Learn how to ask for permissions to access location services, camera, and photo album


# Course Curriculum

## Introduction
- What are your assignment tasks and goals?
- A quick demo of what you’ll build
- Who am I?

## Base Application
- Creating a new Flutter app for Keiko Food Reviews
- Integrating version control by using GitHub
- Laying out the app’s foundation
- Creating base folder structures like helpers, logic, models, pages, services, state, and assets
- Creating dark and light themes
- Running the app and watching themes change automatically according to the device setting

## Basic User Interface Layout
- Introduction to base page structure, responsive layout builder and navigation
- Adding app wide constants
- Adding page stubs for review list, review grid photos and review map locations with default route names
- Adding Responsive Layout Builder Widget for mobile and web
- Adding Responsive Layout Builder handling navigation for mobile
- Continue adding to the Responsive Layout Builder navigation for web
- Adding image assets
- Adding page stubs for user login, register, forgot password, review entry view, review entry edit, and review photo zoom with default route names
- Adding routes navigation helper class
- Into to the CustomClipper class for customizing the reviews list app bar
- Creating the CustomClipper for customizing the reviews list app bar
- Customizing the reviews list app bar

## Add Dependencies
- View different ways to add packages
- Adding Camera, Photo Album, Location, Reverse Geocoding, Map, Firebase Authentication, Cloud Firestore, Cloud Storage packages, Cached Images, and intl packages via flutter pub command
- Configure iOS Info.plist for Image Picker and Geolocator plugins
- Configure Android AndroidManifest.xml Geolocator plugin
- Enable CORS for Web development mode to view photos

## Create the Firebase Project
- Different ways to create a Firebase Project and benefits
- Installing the Firebase CLI and FlutterFire CLI
- Using the FlutterFire CLI to create a new Firebase Project
- Initializing Firebase in the Flutter Project
- Configuring the Android SDK version
- Resources: Firebase CLI, FlutterFire CLI, Android SDK and Multidex links

## Firebase Authentication
- Enabling Authentication Sign-in Providers
- Reviewing Authentication Email Templates
- Creating Authentication Service - Create user
- Creating Authentication Service - Sign in, sign out, password reset, email verification and email verified
- Creating Authentication Business Logic - Part 1 - Validators, login register logic, error handling
- Creating Authentication Business Logic - Part 2 - Private variables, login, register, check login email and password
- Creating Authentication Business Logic - Part 3 - Check register email and password, show login error
- Creating Authentication Business Logic - Part 4 - Create login logic
- Creating Authentication Business Logic - Part 5 - Create user model calls and initialize new user default values
- Creating Authentication Business Logic - Part 6 - Create database service for the user collection database, and add user
- Creating Authentication Business Logic - Part 7 - Add to database service the get and update user
- Creating Authentication Business Logic - Part 8 - Continue login register logic class by adding the register logic
- Creating Authentication State
- Resources: General overview of using Firebase App Check to prevent unauthorized access to our Firebase project, QuickType to create dart classes from JSON

## Overview for Authentication Pages and Navigation
- Introduction and explanations on creating Register User, Login User, and Forgot Password pages before and after implementing Named Navigation

## Customize Register User Page
- Introduction and basic tour and what you’ll build
- Initializing business logic, text editing controllers, and base layout
- Adding image and body structure
- Adding email, password and confirm password entry fields
- Creating the register button
- Creating the register error message
- Creating the login button and navigation

## Customize Login Page
- Introduction and basic tour and what you’ll build
- Initializing business logic, text editing controllers, and base layout
- Adding image and body structure
- Adding email and password entry fields
- Creating the login button
- Creating the login error message
- Creating the forgot password and create user button and navigation

## Customize Forgot Password User Page
- Connecting the business logic
- Adding image and body structure
- Adding email entry field
- Creating the button to reset password or login

## Authentication State Changes and Navigation
- Introduction to Authentication State Changes and Navigation
- Implementing the Authentication State Changes
- Implementing the Named Routes Navigation

## Cloud Storage
- Enabling storage security rules
- Creating storage service and upload photo method
- Creating the delete photo method

## Review Model
- Introduction to the Review Model
- Creating the base Review Model
- Marking some variables and copy with methods optional
- Adding object equality checks
- Adding the Add New Review with Default Values

## Cloud Firestore Database
- Creating Firestore Database from Firebase Console and enabling database security rules
- Adding Reviews Collection to the database service - Add Review
- Adding Reviews Collection to the database service - Update Review - Handle Photo
- Adding Reviews Collection to the database service - Update Review - Handle save to Firestore Database
- Adding Reviews Collection to the database service - Delete Review
- Adding Reviews Collection to the database service - Get Review List
- Adding Reviews Collection to the database service - Get Review List with Photos


## Location Services
- Introduction to the Location Service
- Creating the Location API Keys for Web - Get API Key
- Creating the LocationService - Get Permission and Location
- Creating the LocationService - Get Reverse Geo Coding

## Additional Helpers and Reusable Widgets
- Introduction to Helpers and Reusable Widgets
- Creating app helpers - Arguments
- Creating app helpers - Dialogs
- Creating app helpers - Format Dates
- Creating reusable widgets - Image Circle Shadow
- Creating reusable widgets - Image and Message
- Creating reusable widgets - Muted Text
- Creating reusable widgets - Star Rating - Variables
- Creating reusable widgets - Star Rating - Rating
- Creating reusable widgets - Star Rating - Gesture Detector

## Customize the Review List Page
- Introduction to the Review List Page
- Connecting the Review List (business) Logic
- Modifying Themes Adding Custom Error Color
- Creating the Review List Body Card - Base Layout, Dismissible and Delete Review Confirmation Dialog
- Creating the Review List Body Card - Card, InkWell, Navigation and Hero
- Creating the Review List Body Card - Aspect Ratio and Image Network showing Photo Thumbnail
- Creating the Review List Body Card - Cached Network Image showing Photo Thumbnail
- Creating the Review List Body Card - ListTile Title and Star Rating
- Creating the Review List Body Card - ListTile Subtitle
- Creating the Review List Body - Base Layout adding Custom Scrollview and Image with Message
- Creating the Review List Body - Handle web and mobile showing either a Grid or List of items
- Creating the Review List - Base Layout and Initialize Review List Logic
- Creating the Review List - Refactor, alternate ways to store Stream inside Review List Logic
- Creating the Review List - App Bar, Menu Actions, Add Review and Log Out
- Creating the Review List - Safe Area and Stream Builder showing list of reviews or messages
- Creating the Review List - Floating Action Button, and Navigation
- Creating the Review List - Creating the Cloud Firestore Index
- Customize Review Entry Photo Zoom Page
- Introduction to the Review Entry Photo Zoom Page
- Adding Base Layout, Navigation Arguments, App Bar and Body structure
- Adding the Interactive Viewer to Zoom Image with the Image Network widget
- Adding the alternate way to load image with the Cached Network Image


## Customize Review Entry View Page
- Introduction to the Review View Page
- Adding Base Layout, Navigation Arguments, App Bar and Body structure
- InkWell, Hero and Image Network showing Photo Thumbnail
- Cached Network Image showing Photo Thumbnail
- ListTile - Adding the title property and Star Rating
- ListTile - Subtitle property adding a Column and Review details
- ListTile - Subtile property adding Location Placemark in a Wrap widget
- ListTile - Subtile property adding the Location on a Map with FlutterMap

## Review Entry Edit Logic
- Creating the Review Entry Edit (business) logic, Declaring Variables and Initializing Position Defaults
- Adding the Get Location, Current Position, and Replace Location
- Adding the Delete Location
- Adding the Set Location and Address for Web
- Adding the Set Location and Address for Mobile
- Adding the Checking if Data Changed and Save Review
- Adding the Cancel Editing Review and Delete Review
- Adding the Select Date and Pick Image

## Creating Review Entry Edit Page Widgets
- Introduction to the Review Entry Edit Page Widgets
- Creating the Review Entry Edit App Bar widget - Base Layout
- Creating the Review Entry Edit App Bar widget - Title and Leading properties
- Creating the Review Entry Edit App Bar widget - Actions
- Creating the Review Entry Edit Photo widget - Base Layout
- Creating the Review Entry Edit Photo widget - Image File and Image Network
- Creating the Review Entry Edit Photo widget - Cached Network Image
- Creating the Review Entry Edit Photo widget - Editing Card with Popup Menu Button - Take Photo
- Creating the Review Entry Edit Photo widget - Editing Card with Popup Menu Button - Photo Album, Pick Image, Delete Photo
- Creating the Review Entry Edit Photo widget - Adding Popup Menu Button
- Creating the Review Entry Edit Date Picker widget - Base Layout
- Creating the Review Entry Edit Date Picker widget - Creating the Date Picker Custom Button
- Creating the Review Entry Edit Rating Affordability widget - Base Layout
- Creating the Review Entry Edit Rating Affordability widget - Adding the Star Rating widget
- Creating the Review Entry Edit Rating Affordability widget - Adding the Affordability Segmented Button
- Creating the Review Entry Edit Text Fields widget - Base Layout
- Creating the Review Entry Edit Text Fields widget - Adding the Text Fields Restaurant, and Title
- Creating the Review Entry Edit Text Fields widget - Adding the Text Fields Category and Review
- Creating the Review Entry Edit Placemark and Map widget - Base Layout
- Creating the Review Entry Edit Placemark and Map widget - Adding the Position Value Listenable Builder
- Creating the Review Entry Edit Placemark and Map widget - Adding the Location Placemark
- Creating the Review Entry Edit Placemark and Map widget - Adding the Map
- Creating the Review Entry Edit Placemark and Map widget - Adding the Progress Indicator
- Creating the Review Entry Edit Placemark and Map widget - Adding the Replace Location Button
- Creating the Review Entry Edit Placemark and Map widget - Adding the Delete Location Button

## Customize Review Entry Edit Page
- Introduction to the Review Entry Edit Page
- Adding base layout, connecting Edit (business) Logic, declaring Text Editing Controllers, Value Notifiers, and Map Controller
- Overriding the Did Change Dependencies method
- Overriding the Dispose method
- Adding the Will Pop Scope to Build method
- Adding the Review Entry Edit App Bar widget and layout Body property
- Adding the Review Entry Edit Photo widget and Review Entry Edit Date Picker widget
- Adding the Review Entry Edit Rating and Affordability widget and the Review Entry Edit Text Fields
- Adding the Review Entry Edit Placemark and Map widget

## Customize Review Photos Grid Page
- Introduction to the Review Photos Grid Page
- Creating the Review Photos Grid (business) Logic
- Connecting the Review Photos Grid Logic, App Bar and base layout
- Adding body structure and StreamBuilder base layout
- Adding GridView Builder to StreamBuilder handling Web or Mobile
- Adding InkWell and navigation to photo zoom page
- Adding Image Network
- Adding Cached Network Image
- Adding gradient title bar over image
- Adding Cloud Firestore Index

## Customize Review Map Locations Page
- Introduction to the Review Map Locations Page
- Creating the Review Map Locations (business) Logic
- Creating the Review Map Locations Body widget that implements the Map
- Connecting the Review Map Locations Logic, App Bar and base layout
- Adding StreamBuilder to body, connecting to the Review Map Locations Body
- Update packages, pubspec yaml file

## Refactoring
- Refactoring the User Register, User Login, and User Forgot Password pages AnimatedBuilder to ListenableBuilder
- Refactoring the pubspec.yaml file 100% sound null safety
- Running the Dart Analysis

## Conclusion
- Big Congratulatory Animation. What you have accomplished and learned
- Taking a look at the top widgets, reactivity, functions, methods, techniques used

<br/>  
<br/>  
  
---  

<br/>  
<br/>  

# **Resources**:

The following are different resources for your Flutter Development.  
<br/>

**GitHub - Keiko Food Reviews**  
[https://github.com/JediPixels](https://github.com/JediPixels)

**Image Assets Only**  
[https://github.com/JediPixels/keiko_food_reviews/tree/main/assets/images](https://github.com/JediPixels/keiko_food_reviews/tree/main/assets/images)

**YouTube Channel**  
[https://youtube.com/@JediPixels](https://youtube.com/@JediPixels)

**On Twitter**  
[https://twitter.com/JediPixels](https://twitter.com/JediPixels)

**Flutter Website**  
[https://flutter.dev](https://flutter.dev)

**Dart Website**  
[https://dart.dev](https://dart.dev)

**Official Flutter Packages**  
[https://pub.dev](https://pub.dev)

**Announcing Dart 3 (100% Sound Null Safety)**
[https://medium.com/dartlang/announcing-dart-3-53f065a10635](https://medium.com/dartlang/announcing-dart-3-53f065a10635)

**Sound Null Safety**
[https://dart.dev/null-safety#enable-null-safety](https://dart.dev/null-safety#enable-null-safety)

**Build and Release Android App**  
[https://docs.flutter.dev/deployment/android](https://docs.flutter.dev/deployment/android)

**Build and Release iOS App**  
[https://docs.flutter.dev/deployment/ios](https://docs.flutter.dev/deployment/ios)

**Build and Release Web App**  
[https://docs.flutter.dev/deployment/web](https://docs.flutter.dev/deployment/web)

<br/>  

## **Firebase**

**Firebase Home Page**  
[https://firebase.google.com](https://firebase.google.com)

**Firebase Console**  
[https://console.firebase.google.com](https://console.firebase.google.com)

**Article: App Check**  
[https://firebase.google.com/docs/app-check](https://firebase.google.com/docs/app-check)

**FlutterFire CLI**  
[https://firebase.google.com/docs/flutter/setup?platform=ios](https://firebase.google.com/docs/flutter/setup?platform=ios)

**Android SDK and Multidex**
[https://developer.android.com/build/multidex](https://developer.android.com/build/multidex)

**Restore User’s Data on New Device**
- The user needs to login into the new device and once they login the data is restored and synced.

<br/>  

## **Community Online**

**Flutter Discord**  
[https://discord.com/invite/N7Yshp4](https://discord.com/invite/N7Yshp4)

**Reddit**  
[https://www.reddit.com/r/FlutterDev](https://www.reddit.com/r/FlutterDev)

**Stack Overflow**  
[https://stackoverflow.com/tags/flutter](https://stackoverflow.com/tags/flutter)

**Breaking Changes**
[https://groups.google.com/forum/#!forum/flutter-announce](https://groups.google.com/forum/#!forum/flutter-announce)

**Community Slack**  
[https://fluttercommunity.dev/joinslack](https://fluttercommunity.dev/joinslack)

**Flutter Issue Tracker**  
[https://github.com/flutter/flutter/issues](https://github.com/flutter/flutter/issues)

**Flutter Public Announcements**  
[https://groups.google.com/g/flutter-announce](https://groups.google.com/g/flutter-announce)


  <br/>
  <br/>

# Additional Resources

## Firebase CLI - Setup the FlutterFire CLI
https://youtu.be/FkFvQ0SaT1I  
https://firebase.google.com/docs/flutter/setup?platform=ios  
https://www.youtube.com/playlist?list=PLl-K7zZEsYLnfwBe4WgEw9ao0J0N1LYDR  
<br/>


## **Enable Impeller Engine**
https://docs.flutter.dev/perf/impeller
`flutter run web --enable-impeller` (example)
<br/>

## **Create Production Compiles for iOS and Android**

**Create Android Google Play Version**
`flutter build appbundle --build-number=2` (increase build-number for each release)

**Create Apple Store iOS Version**
`flutter build iOS`


## **Create Production Compiles for Web**
**Web - Run in Chrome Render HTML**
`flutter run -d chrome --web-renderer html`

**Web - Run in Chrome using the default renderer option (auto):**
`flutter run -d chrome`

**Web - Run your app in profile mode using the HTML renderer:**  
`flutter run -d chrome --web-renderer html --profile` (profile to analyze performance)

**Web - Build your app in release mode, using the default (auto) option:**
`flutter build web --release`

**Web - Build your app in release mode, using just the CanvasKit renderer:**
`flutter build web --web-renderer canvaskit --release`

**Web - Build your app in release mode, using just the HTML renderer:**
`flutter build web --release  --web-renderer html`

**Web - Build your app in release mode, using Auto Detect renderer:**
`flutter build web --release  --dart-define=FLUTTER_WEB_AUTO_DETECT=true`
