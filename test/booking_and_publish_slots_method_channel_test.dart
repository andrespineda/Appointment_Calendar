import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:booking_and_publish_slots/booking_and_publish_slots_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelBookingAndPublishSlots platform = MethodChannelBookingAndPublishSlots();
  const MethodChannel channel = MethodChannel('booking_and_publish_slots');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
