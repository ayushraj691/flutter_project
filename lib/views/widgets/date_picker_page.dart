import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  late DateTime _previousYearStart;
  late DateTime _previousYearEnd;

  int _selectedYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _updatePreviousYear(_selectedYear);
    _currentMonth = DateTime.now();
  }

  void _updatePreviousYear(int selectedYear) {
    _previousYearStart = DateTime(selectedYear - 1, 1, 1); // Start of previous year
    _previousYearEnd = DateTime(selectedYear - 1, 12, 31); // End of previous year
  }

  String _formatDate(DateTime? date) {
    return date != null ? DateFormat('dd-MM-yyyy').format(date) : 'dd-mm-yy';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select custom range'),
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
              // First calendar: Previous year of the selected year
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.single,
                    firstDate: _previousYearStart, // Start of previous year
                    lastDate: _previousYearEnd, // End of previous year
                    currentDate: _previousYearStart, // Default to January of the previous year
                  ),
                  value: _startDate != null ? [_startDate!] : [],
                  onValueChanged: (values) {
                    setState(() {
                      _startDate = values.isNotEmpty ? values[0] : null;
                      if (_startDate != null &&
                          _endDate != null &&
                          _startDate!.isAfter(_endDate!)) {
                        _endDate = null;
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Second calendar: Current year
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.single,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    currentDate: _currentMonth,
                  ),
                  value: _endDate != null ? [_endDate!] : [],
                  onValueChanged: (values) {
                    setState(() {
                      _endDate = values.isNotEmpty ? values[0] : null;
                      if (_startDate != null &&
                          _endDate != null &&
                          _startDate!.isAfter(_endDate!)) {
                        _startDate = null;
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
