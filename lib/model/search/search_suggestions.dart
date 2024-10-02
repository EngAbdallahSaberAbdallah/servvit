import 'dart:convert';

class SearchSuggestionsModel {
  final String type;
  final String id;
  final String enName;
  final String arName;
  SearchSuggestionsModel({
    required this.type,
    required this.id,
    required this.enName,
    required this.arName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'id': id,
      'name_en': enName,
      'name_ar': arName,
    };
  }

  factory SearchSuggestionsModel.fromMap(Map<String, dynamic> map) {
    return SearchSuggestionsModel(
      type: map['type'] as String,
      id: map['id'].toString(),
      enName: map['name_en'] as String,
      arName: map['name_ar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchSuggestionsModel.fromJson(String source) =>
      SearchSuggestionsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SearchSuggestionsModel(type: $type, id: $id, enName: $enName, arName: $arName)';
  }
}
