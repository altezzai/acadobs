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
    return DateFormat('MMMM dd, yyyy, HH:mm').format(dateTime); // e.g., "June 15, 2024, 09:00"
  }

  // You can add more custom formatting functions if needed
}
