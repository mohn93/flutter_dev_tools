/// This function takes a map and indent and returns a formatted pretty human readable string.

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
