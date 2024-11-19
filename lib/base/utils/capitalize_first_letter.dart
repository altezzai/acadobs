// capitalize first letter
String capitalizeFirstLetter(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}

// capitalize each word
String capitalizeEachWord(String input) {
  if (input.isEmpty) return input;
  return input
      .split(' ') // Split the string into words
      .map((word) => word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '') // Capitalize the first letter and lowercase the rest
      .join(' '); // Join the words back together
}
