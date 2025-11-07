import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HotandtrendViewModel extends GetxController {
  RxString selectedTab = "".obs;
  Rxn<DateTime> selectedDate = Rxn<DateTime>();
  Rxn<TimeOfDay> selectedTime = Rxn<TimeOfDay>();

  setTab(String tabName) {
    selectedTab.value = tabName;
  }

  Future<void> pickDate({
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final context = Get.context;
    if (context == null) return;

    final rangeStart = firstDate ?? DateTime(2000);
    final rangeEnd = lastDate ?? DateTime(2100);
    final initial = _clampDate(
      initialDate ?? selectedDate.value ?? DateTime.now(),
      rangeStart,
      rangeEnd,
    );

    if (GetPlatform.isIOS || GetPlatform.isMacOS) {
      final picked = await _showCupertinoDatePicker(
        context,
        initial,
        rangeStart,
        rangeEnd,
      );
      if (picked != null) {
        selectedDate.value = picked;
      }
    } else {
      final picked = await showDatePicker(
        context: context,
        initialDate: initial,
        firstDate: rangeStart,
        lastDate: rangeEnd,
        builder: (dialogContext, child) => child ?? const SizedBox.shrink(),
      );
      if (picked != null) {
        selectedDate.value = picked;
      }
    }
  }

  Future<void> pickTime({TimeOfDay? initialTime}) async {
    final context = Get.context;
    if (context == null) return;

    final initial = initialTime ?? selectedTime.value ?? TimeOfDay.now();

    if (GetPlatform.isIOS || GetPlatform.isMacOS) {
      final picked = await _showCupertinoTimePicker(context, initial);
      if (picked != null) {
        selectedTime.value = picked;
      }
    } else {
      final picked = await showTimePicker(
        context: context,
        initialTime: initial,
        builder: (dialogContext, child) => child ?? const SizedBox.shrink(),
      );
      if (picked != null) {
        selectedTime.value = picked;
      }
    }
  }

  DateTime _clampDate(DateTime value, DateTime min, DateTime max) {
    if (value.isBefore(min)) return min;
    if (value.isAfter(max)) return max;
    return value;
  }

  Future<DateTime?> _showCupertinoDatePicker(
    BuildContext context,
    DateTime initial,
    DateTime min,
    DateTime max,
  ) {
    DateTime tempDate = initial;
    return showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (modalContext) {
        final backgroundColor =
            CupertinoTheme.of(modalContext).scaffoldBackgroundColor;
        return Container(
          height: 300,
          color: backgroundColor,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  onPressed: () => Navigator.of(modalContext).pop(tempDate),
                  child: const Text('Done'),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  minimumDate: min,
                  maximumDate: max,
                  initialDateTime: initial,
                  onDateTimeChanged: (value) => tempDate = value,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<TimeOfDay?> _showCupertinoTimePicker(
    BuildContext context,
    TimeOfDay initial,
  ) {
    DateTime tempDate = DateTime(
      1970,
      1,
      1,
      initial.hour,
      initial.minute,
    );
    return showCupertinoModalPopup<TimeOfDay>(
      context: context,
      builder: (modalContext) {
        final backgroundColor =
            CupertinoTheme.of(modalContext).scaffoldBackgroundColor;
        final use24hFormat = MediaQuery.of(modalContext).alwaysUse24HourFormat;
        return Container(
          height: 300,
          color: backgroundColor,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  onPressed: () => Navigator.of(modalContext).pop(
                    TimeOfDay(hour: tempDate.hour, minute: tempDate.minute),
                  ),
                  child: const Text('Done'),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: use24hFormat,
                  initialDateTime: tempDate,
                  onDateTimeChanged: (value) => tempDate = value,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
