
/// Converts a [Map] into a formatted, human-readable string representation.
///
/// This function recursively formats each entry of the map to create a visually
/// appealing and readable string layout. Nested maps and lists are also formatted
/// with increased indentation to preserve their structure visually.
///
/// - Parameters:
///   - [map]: The map to be formatted.
///   - [indent]: The string used for indentation, with a default of two spaces.
///
/// Returns a string representation of the map, formatted for readability.
String prettyMap(Map<String, dynamic> map, {String indent = '  '}) {
  String prettyString = '{\n';
  map.forEach((key, value) {
    prettyString += '$indent$key: ';
    if (value is Map<String, dynamic>) {
      prettyString += prettyMap(value, indent: '$indent  ');
    } else if (value is List) {
      prettyString += prettyList(value, indent: '$indent  ');
    } else {
      prettyString += '$value';
    }
    prettyString += ',\n';
  });
  prettyString += '$indent}';
  return prettyString.trim();
}


/// Converts a [List] into a formatted, human-readable string representation.
///
/// This function iterates through each element of the list, applying formatting
/// similar to `prettyMap` for nested maps and lists to create a readable string layout.
/// Each element in the list is formatted with indentation to align visually in the list structure.
///
/// - Parameters:
///   - [list]: The list to be formatted.
///   - [indent]: The string used for indentation, with a default of two spaces.
///
/// Returns a string representation of the list, formatted for readability.
String prettyList(List<dynamic> list, {String indent = '  '}) {
  String prettyString = '[\n';
  for (var value in list) {
    prettyString += indent;
    if (value is Map<String, dynamic>) {
      prettyString += prettyMap(value, indent: '$indent  ');
    } else if (value is List) {
      prettyString += prettyList(value, indent: '$indent  ');
    } else {
      prettyString += '$value';
    }
    prettyString += ',\n';
  }
  prettyString += '$indent]';
  return prettyString.trim();
}
