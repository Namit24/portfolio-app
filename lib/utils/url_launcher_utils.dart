import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class UrlLauncherUtils {
  static Future<void> launchUrl(String urlString, {BuildContext? context}) async {
    try {
      final Uri url = Uri.parse(urlString);
      final bool canLaunch = await launcher.canLaunchUrl(url);

      if (canLaunch) {
        await launcher.launchUrl(url, mode: launcher.LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch $url');
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open $urlString')),
          );
        }
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening link: $e')),
        );
      }
    }
  }
}
