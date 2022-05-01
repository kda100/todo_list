///class helps with converting enum to their string equivalents.

class EnumValues<T> {
  final Map<String, T> _map;
  final Map<T, String> _reverseMap;

  EnumValues(this._map)
      : _reverseMap = _map.map((key, value) => MapEntry(value, key));

  Map<T, String> get getTypeToValueMap {
    return _reverseMap;
  }

  Map<String, T> get getValueToTypeMap => _map;
}
