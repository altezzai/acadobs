// Import the intl package for date formatting
import 'package:intl/intl.dart';

class DateFormatter {
  // Function to format DateTime object to a specific string format
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd - MM - yy').format(dateTime);
  }

  // Function to format a string date (assuming it's in ISO 8601 format)
  static String formatDateString(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr); // Parse string to DateTime
    return DateFormat('dd - MM - yy').format(dateTime); // Format DateTime
  }

  // Function to format DateTime object to a long-form date with time
  static String formatFullDateTime(DateTime dateTime) {
    return DateFormat('MMMM dd, yyyy, HH:mm')
        .format(dateTime); // e.g., "June 15, 2024, 09:00"
  }

  // You can add more custom formatting functions if needed
}

class TimeFormatter {
  // Function to format DateTime object to a specific time format (e.g., "HH:mm")
  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime); // e.g., "14:30"
  }

  // Function to format DateTime object to a 12-hour format with AM/PM
  static String formatTimeWithAmPm(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime); // e.g., "02:30 PM"
  }

  // Function to format a string time (assuming it's in ISO 8601 format with date)
  static String formatTimeFromString(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return DateFormat('HH:mm').format(dateTime); // e.g., "14:30"
  }

  // Function to format DateTime to show hours, minutes, and seconds
  static String formatFullTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime); // e.g., "14:30:45"
  }

  // Add more custom time formatting functions if needed
}
