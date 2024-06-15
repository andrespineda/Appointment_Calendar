import 'dart:async';
import 'package:booking_and_publish_slots/components/day_picker.dart';
import 'package:booking_and_publish_slots/components/slot_container.dart';
import 'package:booking_and_publish_slots/controller/slots_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class BookingAndPublishSlotsMain extends ConsumerStatefulWidget {
  final String bookedButtonName;
  final List<String> groupLabels;

  //To Set Your Own Group Assets
  final List<String> groupAssets;
  final int numberOfDays;
  final Color selectedDateColor;
  final Color unSelectedDateColor;
  final Color selectedSlotsColor;
  final Color selectedSlotsBorderColor;
  final Color unSelectedSlotsColor;
  final Color unSelectedSlotsBorderColor;
  final Color bookedSlotsColor;
  final Color bookedSlotsBorderColor;

  const BookingAndPublishSlotsMain({
    Key? key,
    this.numberOfDays = 7,
    this.bookedButtonName = "Book Slot",
    this.selectedDateColor = const Color(0xFFFFC93C),
    this.unSelectedDateColor = Colors.white,
    this.selectedSlotsColor = const Color(0xFFFFF6DE),
    this.selectedSlotsBorderColor = const Color(0xFFFFC93C),
    this.unSelectedSlotsColor = Colors.white,
    this.unSelectedSlotsBorderColor = const Color(0xFFE3E3E3),
    this.bookedSlotsColor = const Color(0x1A13176A),
    this.bookedSlotsBorderColor = const Color(0xE613176A),
    this.groupLabels = const [
      "Night (12 AM - 6 AM)",
      "Morning (6 AM - 12 PM)",
      "Afternoon (12 PM - 6 PM)",
      "Evening (6 PM - 12 AM)"
    ],
    this.groupAssets = const [
      "packages/booking_and_publish_slots/assets/sunrise.svg",
      "packages/booking_and_publish_slots/assets/sunrise.svg",
      "packages/booking_and_publish_slots/assets/sunrise.svg",
      "packages/booking_and_publish_slots/assets/sunrise.svg"
    ],
  }) : super(key: key);

  @override
  ConsumerState<BookingAndPublishSlotsMain> createState() =>
      _BookingAndPublishSlotsMainState();
}

class _BookingAndPublishSlotsMainState
    extends ConsumerState<BookingAndPublishSlotsMain> {
  late List<bool> showMoreList =
      ref.watch(bookingSelectionProvider).showMoreList;

  late DateTime selectedDate = ref.watch(selectedDateProvider);

  bool isRefresh = true;

  ///Find Duration for Refresh Screen
  Duration findDuration() {
    final nextMinute = DateTime.now().minute;

    // Calculate the number of minutes to the next 15-minute interval
    final minutesToAdd = nextMinute % 15 == 0 ? 0 : 15 - (nextMinute % 15);

    // Calculate the seconds to the next interval
    final secondsToAdd = 60 - DateTime.now().second;

    // Create a Duration with both minutes and seconds
    final delayDuration =
        Duration(minutes: minutesToAdd - 1, seconds: secondsToAdd);

    return delayDuration;
  }

  @override
  Widget build(BuildContext context) {
    ///Booked slots list
    if (kDebugMode) {
      print("Booked Slots List: ${ref.watch(slotsProvider).bookedSlotsList}");
    }

    if (isRefresh) {
      if (kDebugMode) {
        print('Refresh Screen after ${findDuration()} minutes');
      }
      Future.delayed(findDuration(), () {
        if (kDebugMode) {
          print('<<<<<<< Screen Refresh >>>>>>>');
        }
        setState(() {
          isRefresh = false;
        });
      });
    } else {
      Future.delayed(const Duration(minutes: 1), () {
        setState(() {
          isRefresh = true;
        });
      });
    }

    selectedDate = ref.watch(selectedDateProvider);

    List<DateTime> data = generateTimeIntervals(selectedDate);

    int todayData = generateTimeIntervals(DateTime.now()).length;

    List<int> numberOfSlotsDayWise = List.filled(widget.numberOfDays, 96);
    // Fill the list with 96 initially

    numberOfSlotsDayWise[0] = todayData;
    // Replace the first index with the given data

    return Scaffold(
      bottomNavigationBar: ref
              .watch(bookingSelectionProvider)
              .selectedSlotsList
              .isNotEmpty

          ///Reset And Book button
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(bookingSelectionProvider)
                                  .removeAllSelectedSlot();
                            },
                            child: const Text("Reset All"))),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              ref.read(slotsProvider).bookSlot(ref
                                  .watch(bookingSelectionProvider)
                                  .selectedSlotsList);

                              ref
                                  .read(bookingSelectionProvider)
                                  .removeAllSelectedSlot();
                            },
                            child: Text(widget.bookedButtonName))),
                  ),
                ],
              ),
            )
          : null,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),

          ///Calender Generate
          MyDayPicker(
              slots: numberOfSlotsDayWise,
              isUseForPublishSlots: true,
              numberOfDays: widget.numberOfDays,
              selectedDateColor: widget.selectedDateColor,
              unSelectedDateColor: widget.unSelectedDateColor),

          const Padding(
            padding: EdgeInsets.only(top: 10, left: 8, bottom: 10),
            child: Text(
              "Choose Slot Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final groupIndex = index ~/ 8;

                  // Determine the group index
                  final itemInGroupIndex =
                      index % 8; // Determine the index within the group

                  if (groupIndex < widget.groupLabels.length &&
                      itemInGroupIndex == 0) {
                    // Display separator and label at the beginning of each group
                    final groupData = data.where((time) {
                      final hour = time.hour;
                      if (groupIndex == 0) {
                        // Night group (12 AM - 6 AM)
                        return hour >= 0 && hour < 6;
                      } else if (groupIndex == 1) {
                        // Morning group (6 AM - 12 PM)
                        return hour >= 6 && hour < 12;
                      } else if (groupIndex == 2) {
                        // Afternoon group (12 PM - 6 PM)
                        return hour >= 12 && hour < 18;
                      } else if (groupIndex == 3) {
                        // Evening group (6 PM - 12 AM)
                        return hour >= 18 && hour < 24;
                      }
                      return false;
                    }).toList();

                    final groupName = widget.groupLabels[groupIndex];

                    final showMoreItemCount = showMoreList[groupIndex]
                        ? groupData.length
                        : groupData.length > 8
                            ? 8
                            : groupData.length;

                    return Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFFE3E3E3), width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [

                            Row(
                              children: [
                                SvgPicture.asset(
                                  widget.groupAssets[groupIndex],
                                  height: 30,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  groupData.isNotEmpty
                                      ? "$groupName (Slots ${groupData.length.toString()})"
                                      : groupName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ],
                            ),

                            ///Divider
                            const Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 8),
                              child: Divider(
                                thickness: 2,
                                color: Color(0xFFE3E3E3),
                              ),
                            ),

                            groupData.isEmpty
                                ? const Center(child: Text('No Slot'))
                                : GridView.count(
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 4,
                                    childAspectRatio: 2.0,
                                    children: List.generate(showMoreItemCount,
                                        (gridIndex) {
                                      final time = groupData[gridIndex];
                                      final isSelected = ref
                                          .read(bookingSelectionProvider)
                                          .isSelectedSlot(time);
                                      final formattedDateTime =
                                          DateFormat('hh:mm a').format(time);

                                      ///Slot Container
                                      return SlotContainer(
                                        containerColor: time
                                                .isBefore(DateTime.now())
                                            ? const Color(0xFFE3E3E3)
                                            : ref
                                                    .watch(slotsProvider)
                                                    .isBooked(time)
                                                ? widget.bookedSlotsColor
                                                : isSelected
                                                    ? widget.selectedSlotsColor
                                                    : widget
                                                        .unSelectedDateColor,
                                        containerBorderColor: time
                                                .isBefore(DateTime.now())
                                            ? const Color(0xFFE3E3E3)
                                            : ref
                                                    .watch(slotsProvider)
                                                    .isBooked(time)
                                                ? widget.bookedSlotsBorderColor
                                                : isSelected
                                                    ? widget
                                                        .selectedSlotsBorderColor
                                                    : widget
                                                        .unSelectedSlotsBorderColor,
                                        slotTime: formattedDateTime,
                                        slotTimeColor:
                                            time.isBefore(DateTime.now())
                                                ? Colors.grey
                                                : Colors.black,
                                        onTap: time.isBefore(DateTime.now())
                                            ? null
                                            : () {
                                                ref
                                                        .watch(slotsProvider)
                                                        .isBooked(time)
                                                    ? null
                                                    : ref
                                                        .read(
                                                            bookingSelectionProvider)
                                                        .toggleSelectedData(
                                                            time);
                                              },
                                      );
                                    }),
                                  ),
                            groupData.isEmpty || groupData.length <= 8
                                ? const SizedBox(
                                    height: 15,
                                  )

                                ///ViewMore and ViewLess
                                : viewMoreAndViewLess(groupData, groupIndex),
                          ],
                        ),
                      ),
                    );
                  } else {
                    // Return an empty container for other items within the group
                    return const SizedBox(
                      height: 2,
                    );
                  }
                },
                itemCount:
                    widget.groupLabels.length * 8, // Total number of items
              ),
            ),
          ),
        ],
      ),
    );
  }

  viewMoreAndViewLess(List<DateTime> groupData, int groupIndex) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Align(
        alignment: Alignment.bottomRight,
        child: InkWell(
          onTap: () {
            groupData.length > 8
                ? ref.read(bookingSelectionProvider).toggleShowMore(groupIndex)
                : null;
          },
          child: Text(
            showMoreList[groupIndex] ? 'View Less' : 'View More',
            style: const TextStyle(
                color: Colors.orangeAccent,
                decoration: TextDecoration.underline,
                decorationColor: Colors.orangeAccent),
          ),
        ),
      ),
    );
  }
}
