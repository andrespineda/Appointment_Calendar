// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'booking_and_publish_slots_platform_interface.dart';

/// A web implementation of the BookingAndPublishSlotsPlatform of the BookingAndPublishSlots plugin.
class BookingAndPublishSlotsWeb extends BookingAndPublishSlotsPlatform {
  /// Constructs a BookingAndPublishSlotsWeb
  BookingAndPublishSlotsWeb();

  static void registerWith(Registrar registrar) {
    BookingAndPublishSlotsPlatform.instance = BookingAndPublishSlotsWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = html.window.navigator.userAgent;
    return version;
  }
}
