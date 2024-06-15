import 'package:booking_and_publish_slots/components/booking_and_publish_slots_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingAndPublishSlots extends StatelessWidget {
  const BookingAndPublishSlots({super.key});

  @override
  Widget build(BuildContext context) {
    return  const ProviderScope(child: BookingAndPublishSlotsMain());
  }
}



