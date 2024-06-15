import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'booking_and_publish_slots_method_channel.dart';

abstract class BookingAndPublishSlotsPlatform extends PlatformInterface {
  /// Constructs a BookingAndPublishSlotsPlatform.
  BookingAndPublishSlotsPlatform() : super(token: _token);

  static final Object _token = Object();

  static BookingAndPublishSlotsPlatform _instance = MethodChannelBookingAndPublishSlots();

  /// The default instance of [BookingAndPublishSlotsPlatform] to use.
  ///
  /// Defaults to [MethodChannelBookingAndPublishSlots].
  static BookingAndPublishSlotsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BookingAndPublishSlotsPlatform] when
  /// they register themselves.
  static set instance(BookingAndPublishSlotsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
