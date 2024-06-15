import 'package:booking_and_publish_slots/controller/slots_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

final selectedDateProvider = StateProvider.autoDispose<DateTime>((ref) {
  return DateTime.now();
});

class MyDayPicker extends ConsumerStatefulWidget {
  final List<int>? slots;
  final bool isUseForPublishSlots;
  final int numberOfDays;
  final Color selectedDateColor;
  final Color unSelectedDateColor;

  const MyDayPicker({
    required this.slots,
    required this.isUseForPublishSlots,
    required this.numberOfDays,
    required this.selectedDateColor,
    required this.unSelectedDateColor,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MyDayPickerState();
}

class _MyDayPickerState extends ConsumerState<MyDayPicker> {
  String getDayName(int weekday) =>
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][weekday - 1];

  List<DateTime> generateDayIntervals() {
    final List<DateTime> dayIntervals = [];
    final now = DateTime.now();

    for (int i = 0; i < widget.numberOfDays; i++) {
      final date = now.add(Duration(days: i));
      dayIntervals.add(date);
    }

    return dayIntervals;
  }

  @override
  Widget build(BuildContext context) {

    List<DateTime> intervals = generateDayIntervals();

    var selectedDate = ref.watch(selectedDateProvider);

    return SizedBox(
      height: 75,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: intervals.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              ref.read(selectedDateProvider.notifier).state = intervals[index];
              ref.read(bookingSelectionProvider).removeAllSelectedSlot();
              ref.read(bookingSelectionProvider).resetAllShowMore();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: intervals[index].day == selectedDate.day
                    ? widget.selectedDateColor
                    : widget.unSelectedDateColor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    getDayName(intervals[index].weekday)
                        .toString()
                        .toUpperCase(),
                    style: TextStyle(
                        color: intervals[index].day == selectedDate.day
                            ? Colors.white
                            : Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    intervals[index].day.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "${widget.slots![index].toString()} Slots",
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 8,
          );
        },
      ),
    );
  }
}
