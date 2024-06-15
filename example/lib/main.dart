import 'package:booking_and_publish_slots/booking_and_publish_slots.dart';
import 'package:booking_and_publish_slots/components/booking_and_publish_slots_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        // useMaterial3: true,
        // colorSchemeSeed: const Color(0x9f4376f8),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BookingAndPublishSlots example app'),
        ),
        body: const BookingAndPublishSlots(),
      ),
    );
  }
}
