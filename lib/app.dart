import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:diary/localization.dart';
import 'package:diary/models.dart';
import 'package:diary/widgets.dart';
import 'package:leitmotif/leitmotif.dart';

class App extends StatefulWidget {
  /// States whether the app runs in debug mode.
  ///
  /// This will prevent debug output to be printed.
  static const bool DEBUG = false;

  /// The application's name.
  static const String appName = "Personal Diary";

  /// The application's slogan.
  static const String appSlogan = "By Ossama 3alama :D.";

  /// The application's developer.
  static const String appDeveloper = "OssTech EG";

  static const imageCollectionPath = 'assets/json/image_collection_data.json';

  static const supportedLocales = AppLocalizations.supportedLocales;

  static const supportedLanguages = const [
    EN.languageCode,
    // DE.languageCode,
  ];

  /// Restarts the whole application by creating a new [UniqueKey] on the
  /// uppermost widget ([MaterialApp]).
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_AppState>()!.restartApp();
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Key _key = UniqueKey();

  /// The background photos fetched from local storage.
  List<String?> backdropPhotoUrlList = [];

  /// The list of images required to load from local storage.
  final List<String> utilityImagesUrlList = const [
    "assets/images/diary_256px.png",
    "assets/images/Key.png",
    "assets/images/Curtain_Left.png",
    "assets/images/Curtain_Right.png",
    "assets/images/Window.png",
    "assets/images/Cloud.png",
    "assets/images/window_Artwork_Small.png"
  ];

  /// Parses the provided assets data formatted as a string value in order to
  /// create [BackdropPhoto] instances.
  void parseBackdropPhotos(String assetData) {
    final parsed = jsonDecode(assetData).cast<Map<String, dynamic>>();
    parsed.forEach(
      (json) {
        setState(
          () {
            backdropPhotoUrlList.add(BackdropPhoto.fromJson(json).assetUrl);
          },
        );
      },
    );
  }

  /// Loads the `JSON` file content and initiates the parsing process.
  Future<void> loadPhotosFromJson() async {
    String data = await rootBundle.loadString(App.imageCollectionPath);
    return parseBackdropPhotos(data);
  }

  /// Restart the app globally by creating a new [UniqueKey].
  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();
    ImageCacheController(
      context: context,
      assetImages: utilityImagesUrlList,
    );
    loadPhotosFromJson().then(
      (value) => ImageCacheController(
        context: context,
        assetImages: backdropPhotoUrlList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: MaterialApp(
        debugShowCheckedModeBanner: App.DEBUG,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.grey,
          primaryColor: Colors.grey[50],
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          LeitmotifLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        /// Supported languages
        supportedLocales: App.supportedLocales,
        title: App.appName,
        home: DatabaseStateScreenBuilder(),
      ),
    );
  }
}
