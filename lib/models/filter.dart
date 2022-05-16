class Filter {
  String? name;
  int? frequency;

  Filter({this.name, this.frequency});

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['frequency'] = frequency;
    return _data;
  }

  factory Filter.fromJson(Map<String, dynamic> Json) {
    Filter newFilter = Filter(name: Json['name'], frequency: Json['frequency']);
    return newFilter;
  }

  static List<String> convertToStringList(dynamic values) {
    List<String> result = [];

    for (var item in values) {
      result.add(item.name);
    }

    return result;
  }
}
