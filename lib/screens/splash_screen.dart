import 'package:flutter/material.dart';
import 'package:diary/widgets.dart';
import 'package:leitmotif/leitmotif.dart';

/// A screen widget to display a minimalist HistoryOfMe logo while the
/// application being loaded.
class SplashScreen extends StatelessWidget {
  /// Creates a [SplashScreen].
  const SplashScreen();
  @override
  Widget build(BuildContext context) {
    return LitStaticLoadingScreen(
      child: DiaryAppLogo(
        color: LitColors.grey350,
        showKeyImage: false,
      ),
    );
  }
}
