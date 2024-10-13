import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendar extends StatefulWidget {
  final Function(DateTime) onSelectDate;
  final bool isEnabled; // Add this field

  CustomCalendar(
      {required this.onSelectDate,
      this.isEnabled = true}); // Default isEnabled to true

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime _currentDate;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _selectedDate = DateTime.now();
  }

  void _onDateSelected(DateTime date) {
    if (widget.isEnabled) {
      // Only allow date selection if enabled
      setState(() {
        _selectedDate = date;
      });
      widget.onSelectDate(date);
    }
  }

  void _previousMonth() {
    if (widget.isEnabled) {
      // Only allow month change if enabled
      setState(() {
        _currentDate = DateTime(_currentDate.year, _currentDate.month - 1, 1);
      });
    }
  }

  void _nextMonth() {
    if (widget.isEnabled) {
      // Only allow month change if enabled
      setState(() {
        _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Select Date',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('EEEE, d/M').format(_selectedDate),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Icon(Icons.edit, size: 20),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(_currentDate),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: _previousMonth, // Only change month if enabled
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: _nextMonth, // Only change month if enabled
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildCalendarGrid(),
          SizedBox(height: 16),
          if (widget.isEnabled) // Only show the buttons if enabled
            ElevatedButton(
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () => widget.onSelectDate(_selectedDate),
            ),
          SizedBox(height: 8),
          if (widget.isEnabled) // Only show the buttons if enabled
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.pink)),
              onPressed: () => Navigator.of(context).pop(),
            ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: 7 + _daysInMonth(_currentDate),
      itemBuilder: (context, index) {
        if (index < 7) {
          return Center(
            child: Text(
              ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }
        final day = index - 6;
        final date = DateTime(_currentDate.year, _currentDate.month, day);
        final isSelected = _selectedDate.year == date.year &&
            _selectedDate.month == date.month &&
            _selectedDate.day == day;

        return GestureDetector(
          onTap: widget.isEnabled ? () => _onDateSelected(date) : null,
          child: Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.pink : Colors.transparent,
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int _daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }
}
