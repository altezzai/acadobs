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
    return DateFormat('MMMM dd, yyyy, hh:mm a') // 12-hour format with AM/PM
        .format(dateTime); // e.g., "June 15, 2024, 09:00 AM"
  }
}

class TimeFormatter {
  // Function to format DateTime object to a 12-hour format with AM/PM
  static String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime); // e.g., "02:30 PM"
  }

  // Function to format a string time (assuming it's in ISO 8601 format with date)
  static String formatTimeFromString(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return DateFormat('hh:mm a').format(dateTime); // e.g., "02:30 PM"
  }

  // Function to format DateTime to show hours, minutes, and seconds in 12-hour format
  static String formatFullTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss a').format(dateTime); // e.g., "02:30:45 PM"
  }
}
