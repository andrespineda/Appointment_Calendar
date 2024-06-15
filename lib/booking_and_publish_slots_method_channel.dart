import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'booking_and_publish_slots_platform_interface.dart';

/// An implementation of [BookingAndPublishSlotsPlatform] that uses method channels.
class MethodChannelBookingAndPublishSlots extends BookingAndPublishSlotsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('booking_and_publish_slots');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
