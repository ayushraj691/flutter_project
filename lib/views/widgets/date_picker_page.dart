import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paycron/utils/color_constants.dart';
import '../../utils/style.dart';

class RangeDatePickerScreen extends StatefulWidget {
  final void Function(DateTime? pickStartDate, DateTime? pickEndDate) onSubmit;

  const RangeDatePickerScreen({super.key, required this.onSubmit});

  @override
  RangeDatePickerScreenState createState() => RangeDatePickerScreenState();
}

class RangeDatePickerScreenState extends State<RangeDatePickerScreen> {
  DateTime? _startDate;
  DateTime? _endDate;

  late DateTime _currentMonth;
  late DateTime _previousMonthStart;
  late DateTime _previousMonthEnd;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    // Calculate the previous month
    _previousMonthStart = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    _previousMonthEnd = DateTime(_currentMonth.year, _currentMonth.month, 0);
  }

  String _formatDate(DateTime? date) {
    return date != null ? DateFormat('dd-MM-yyyy').format(date) : 'dd-mm-yy';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackgroundColor,
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          color: AppColors.appBlackColor,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text('Select custom range',style: AppTextStyles.boldText,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildDateField('Start Date', _startDate)),
                  const SizedBox(width: 20.0),
                  Expanded(child: _buildDateField('End Date', _endDate)),
                ],
              ),
              const SizedBox(height: 12),
              // First calendar: Previous month of the current month
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.single,
                    firstDate:  DateTime(1900), // Start of the previous month
                    lastDate: _previousMonthEnd, // End of the previous month
                    currentDate: _previousMonthStart, // Default to the start of the previous month
                  ),
                  value: _startDate != null ? [_startDate!] : [],
                  onValueChanged: (values) {
                    setState(() {
                      _startDate = values.isNotEmpty ? values[0] : null;
                      // If a start date is selected, ensure the end date is after the start date
                      if (_startDate != null && _endDate != null && _startDate!.isAfter(_endDate!)) {
                        _endDate = null;  // Clear the end date if it's before the start date
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Second calendar: Current month
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.single,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2030),
                    currentDate: _currentMonth, // Current month for the second calendar
                  ),
                  value: _endDate != null ? [_endDate!] : [],
                  onValueChanged: (values) {
                    setState(() {
                      // Set the end date to the second calendar's selected date
                      _endDate = values.isNotEmpty ? values[0] : null;
                      // If start date is set, ensure the end date is after the start date
                      if (_startDate != null && _endDate != null && _startDate!.isAfter(_endDate!)) {
                        _startDate = null;  // Reset start date if the end date is before
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _startDate != null && _endDate != null
                      ? () {
                    widget.onSubmit(_startDate, _endDate);
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'See Results',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date) {
    TextEditingController dateController = TextEditingController();
    dateController.text = _formatDate(date);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: dateController,
          enabled: false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12.0),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }
}
