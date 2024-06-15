import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<DateTime> generateTimeIntervals(DateTime selectedDate) {
  final List<DateTime> intervals = [];
  final start =
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

  for (int j = 0; j < 96; j++) {
    final time = start.add(Duration(minutes: j * 15));
    intervals.add(time);
  }
  // }

  return intervals;
}

final slotsProvider = ChangeNotifierProvider<MySlotsProvider>((ref) {
  return MySlotsProvider();
});

class MySlotsProvider extends ChangeNotifier {
  List<DateTime> bookedSlotsList = [];

  List<DateTime> availableSlots = [];

  // getAvailableSlots(List<DateTime> slotsList) {
  //   availableSlots = slotsList;
  //   notifyListeners();
  //   return availableSlots;
  // }

  List<DateTime> getBookedSlots() {
    return bookedSlotsList;
  }

  void bookSlot(List<DateTime> selectedSlots) {
    bookedSlotsList.addAll(selectedSlots);
    bookedSlotsList.sort();
    notifyListeners();
  }

  // void togglePublishedSlots(DateTime time) {
  //   if (bookedSlotsList.contains(time)) {
  //     bookedSlotsList.remove(time);
  //   } else {
  //     bookedSlotsList.add(time);
  //   }
  //   notifyListeners();
  // }

  bool isBooked(DateTime time) {
    return bookedSlotsList.contains(time);
  }
}



final bookingSelectionProvider = ChangeNotifierProvider.autoDispose<MyBookingSelectionProvider>((ref) {
  return MyBookingSelectionProvider();
});

class MyBookingSelectionProvider extends ChangeNotifier {
  final List<DateTime> selectedSlotsList = [];

  final List<bool> showMoreList = [false, false, false, false];

  void toggleSelectedData(DateTime time) {
    if (selectedSlotsList.contains(time)) {
      selectedSlotsList.remove(time);
    } else {
      selectedSlotsList.add(time);
    }
    notifyListeners();
  }

  bool isSelectedSlot(DateTime time) {
    return selectedSlotsList.contains(time);
  }

  void removeAllSelectedSlot() {
    selectedSlotsList.clear();
    notifyListeners();
  }

  void toggleShowMore(int index) {
    showMoreList[index] = !showMoreList[index];
    notifyListeners();
  }

  void resetAllShowMore() {
    showMoreList.fillRange(0, showMoreList.length, false);
    notifyListeners();
  }
}


