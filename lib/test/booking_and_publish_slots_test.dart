import 'package:flutter_test/flutter_test.dart';
import 'package:booking_and_publish_slots/booking_and_publish_slots_platform_interface.dart';
import 'package:booking_and_publish_slots/booking_and_publish_slots_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBookingAndPublishSlotsPlatform
    with MockPlatformInterfaceMixin
    implements BookingAndPublishSlotsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BookingAndPublishSlotsPlatform initialPlatform = BookingAndPublishSlotsPlatform.instance;

  test('$MethodChannelBookingAndPublishSlots is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBookingAndPublishSlots>());
  });


}
