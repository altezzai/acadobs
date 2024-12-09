import 'package:intl/intl.dart';

Map<String, List<T>> groupItemsByDate<T>(
    List<T> items, DateTime Function(T) getDate) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));

  Map<String, List<T>> groupedItems = {};

  for (var item in items) {
    final itemDate =
        DateTime(getDate(item).year, getDate(item).month, getDate(item).day);
    String formattedDate;

    if (itemDate == today) {
      formattedDate = "Today";
    } else if (itemDate == yesterday) {
      formattedDate = "Yesterday";
    } else {
      formattedDate = DateFormat.yMMMMd().format(itemDate);
    }

    if (!groupedItems.containsKey(formattedDate)) {
      groupedItems[formattedDate] = [];
    }
    groupedItems[formattedDate]!.add(item);
  }

  // Sort categories, with "Today" and "Yesterday" on top
  List<MapEntry<String, List<T>>> sortedEntries = [];
  if (groupedItems.containsKey("Today")) {
    sortedEntries.add(MapEntry("Today", groupedItems["Today"]!));
    groupedItems.remove("Today");
  }
  if (groupedItems.containsKey("Yesterday")) {
    sortedEntries.add(MapEntry("Yesterday", groupedItems["Yesterday"]!));
    groupedItems.remove("Yesterday");
  }

  sortedEntries.addAll(
      groupedItems.entries.toList()..sort((a, b) => b.key.compareTo(a.key)));

  return Map.fromEntries(sortedEntries);
}
