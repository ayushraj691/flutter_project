import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScheduleController extends GetxController {
  var selectedStartOption = "immediately".obs;
  var selectedEndOption = "monthly_cycle".obs;
  var selectedFrequency = "Monthly".obs; // Set default to "Monthly"
  var customStartDate = DateTime.now().obs;
  var customEndDate = DateTime.now().add(const Duration(days: 30)).obs;
  var customDayOffset = 0.obs;
  var cycleCount = 1.obs;

  void setStartOption(String option) {
    selectedStartOption.value = option;
    _updateStartDate();
    _updateEndDate();
  }

  void setFrequency(String frequency) {
    selectedFrequency.value = frequency;
    _updateEndDate();
  }

  void setCustomStartDate(DateTime? date) {
    if (date != null) {
      customStartDate.value = date;
      _updateEndDate();
    }
  }

  void setCustomEndDate(DateTime? date) {
    if (date != null) {
      customEndDate.value = date;
    }
  }

  void setCustomDayOffset(int days) {
    customDayOffset.value = days;
    _updateEndDate();
  }

  void setCycleCount(String count) {
    cycleCount.value = int.tryParse(count) ?? 1;
    _updateEndDate();
  }

  void _updateStartDate() {
    if (selectedStartOption.value == "immediately") {
      customStartDate.value = DateTime.now();
    } else if (selectedStartOption.value == "next_month") {
      customStartDate.value =
          DateTime(DateTime.now().year, DateTime.now().month + 1, 1);
    }
  }

  void _updateEndDate() {
    if (selectedEndOption.value == "custom_day_offset") {
      customEndDate.value =
          customStartDate.value.add(Duration(days: customDayOffset.value));
    } else if (selectedEndOption.value == "monthly_cycle") {
      switch (selectedFrequency.value) {
        case "Weekly":
          customEndDate.value =
              customStartDate.value.add(Duration(days: 7 * cycleCount.value));
          break;
        case "Biweekly":
          customEndDate.value =
              customStartDate.value.add(Duration(days: 14 * cycleCount.value));
          break;
        case "Monthly":
          final tentativeEndDate = DateTime(
            customStartDate.value.year,
            customStartDate.value.month + cycleCount.value,
            customStartDate.value.day,
          );
          customEndDate.value =
              tentativeEndDate.subtract(const Duration(days: 1));
          break;
        case "Quarterly":
          final tentativeEndDate = DateTime(
            customStartDate.value.year,
            customStartDate.value.month + (3 * cycleCount.value),
            customStartDate.value.day,
          );
          customEndDate.value =
              tentativeEndDate.subtract(const Duration(days: 1));
          break;
        case "Half yearly":
          final tentativeEndDate = DateTime(
            customStartDate.value.year,
            customStartDate.value.month + (6 * cycleCount.value),
            customStartDate.value.day,
          );
          customEndDate.value =
              tentativeEndDate.subtract(const Duration(days: 1));
          break;
        case "Yearly":
          final tentativeEndDate = DateTime(
            customStartDate.value.year + cycleCount.value,
            customStartDate.value.month,
            customStartDate.value.day,);
          customEndDate.value =
              tentativeEndDate.subtract(const Duration(days: 1));
          break;
      }
    }
  }
}

void showScheduleSubscriptionDialog(BuildContext context) {
  final ScheduleController controller = Get.put(ScheduleController());

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title and Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Schedule Subscription",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Obx(() {
                  return DropdownButton<String>(
                    value: controller.selectedFrequency.value,
                    underline: const SizedBox(),
                    dropdownColor: Colors.blue[50],
                    items: [
                      "Weekly",
                      "Biweekly",
                      "Monthly",
                      "Quarterly",
                      "Half yearly",
                      "Yearly"
                    ]
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      controller.setFrequency(value!);
                    },
                  );
                }),
              ],
            ),
            const SizedBox(height: 16),

            _buildSectionTitle("Start"),
            const SizedBox(height: 8),
            Obx(() {
              return _buildRadioOption(
                "Immediately",
                DateFormat("dd-MM-yyyy").format(DateTime.now()),
                value: "immediately",
                groupValue: controller.selectedStartOption.value,
                activeColor:
                    controller.selectedStartOption.value == "immediately"
                        ? Colors.blue
                        : Colors.grey,
                onSelect: () {
                  controller.setStartOption("immediately");
                },
              );
            }),
            Obx(() {
              return _buildRadioOption(
                "On the 1st of Next Month",
                DateFormat("dd-MM-yyyy").format(
                    DateTime(DateTime.now().year, DateTime.now().month + 1, 1)),
                value: "next_month",
                groupValue: controller.selectedStartOption.value,
                activeColor:
                    controller.selectedStartOption.value == "next_month"
                        ? Colors.blue
                        : Colors.grey,
                onSelect: () {
                  controller.setStartOption("next_month");
                },
              );
            }),
            Obx(() {
              return _buildCustomDateFieldOption(
                context,
                "On a Custom Date",
                controller.customStartDate.value != null
                    ? DateFormat("dd-MM-yyyy")
                        .format(controller.customStartDate.value)
                    : "Select",
                value: "custom",
                groupValue: controller.selectedStartOption.value,
                activeColor: controller.selectedStartOption.value == "custom"
                    ? Colors.blue
                    : Colors.grey,
                onSelect: () {
                  _pickDate(context, (pickedDate) {
                    controller.setCustomStartDate(pickedDate);
                  });
                },
              );
            }),
            const SizedBox(height: 16),
            _buildSectionTitle("End"),
            const SizedBox(height: 8),
            Obx(() {
              return _buildRadioOptionWithInput(
                context,
                "Monthly Cycle",
                value: "monthly_cycle",
                groupValue: controller.selectedEndOption.value,
                activeColor:
                    controller.selectedEndOption.value == "monthly_cycle"
                        ? Colors.blue
                        : Colors.grey,
                onSelect: () {
                  controller.selectedEndOption.value = "monthly_cycle";
                  controller._updateEndDate();
                },
                controller: controller,
              );
            }),
            Obx(() {
              return _buildCustomDateFieldOption(
                context,
                "On A Custom Date",
                controller.customEndDate.value != null
                    ? DateFormat("dd-MM-yyyy")
                        .format(controller.customEndDate.value)
                    : "Select",
                value: "custom",
                groupValue: controller.selectedEndOption.value,
                activeColor: controller.selectedEndOption.value == "custom"
                    ? Colors.blue
                    : Colors.grey,
                onSelect: () {
                  _pickDate(context, (pickedDate) {
                    controller.setCustomEndDate(pickedDate);
                  });
                },
              );
            }),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.calendar_month),
              label: const Text(
                "Schedule",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                final ScheduleController controller =
                    Get.find<ScheduleController>();
                debugPrint("Start Date: ${controller.customStartDate.value}");
                debugPrint("End Date: ${controller.customEndDate.value}");
                debugPrint("Frequency: ${controller.selectedFrequency.value}");
                debugPrint(
                    "Monthly Cycle: ${controller.selectedEndOption.value}");
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildSectionTitle(String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );
}

Widget _buildRadioOption(
  String title,
  String subtitle, {
  required String value,
  required String groupValue,
  required VoidCallback onSelect,
  required Color activeColor,
}) {
  return InkWell(
    onTap: onSelect,
    child: Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: (_) => onSelect(),
          activeColor: activeColor,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        const Spacer(),
        if (subtitle.isNotEmpty)
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
      ],
    ),
  );
}

Widget _buildRadioOptionWithInput(
  BuildContext context,
  String title, {
  required String value,
  required String groupValue,
  required VoidCallback onSelect,
  required Color activeColor,
  required ScheduleController controller,
}) {
  return Row(
    children: [
      Radio<String>(
        value: value,
        groupValue: groupValue,
        onChanged: (_) => onSelect(),
        activeColor: activeColor,
      ),
      Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      const Spacer(),
      if (value == "monthly_cycle")
        SizedBox(
          width: 50,
          child: TextField(
            decoration: const InputDecoration(
              hintText: "1",
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              controller.setCycleCount(value);
            },
          ),
        ),
    ],
  );
}

Widget _buildCustomDateFieldOption(
  BuildContext context,
  String title,
  String dateText, {
  required String value,
  required String groupValue,
  required VoidCallback onSelect,
  required Color activeColor,
}) {
  return InkWell(
    onTap: onSelect,
    child: Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: (_) => onSelect(),
          activeColor: activeColor,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onSelect,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              dateText,
              style: TextStyle(
                  fontSize: 14,
                  color: dateText == "Select" ? Colors.grey : Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}

void _pickDate(
    BuildContext context, ValueChanged<DateTime?> onDateSelected) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  if (pickedDate != null) {
    onDateSelected(pickedDate);
  }
}
