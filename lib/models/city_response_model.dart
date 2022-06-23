import 'dart:convert';

List<CityResponseModel> cityResponseJson(str) {
  List jsonResponse = json.decode(str);
  return jsonResponse.map((data) => CityResponseModel.fromJson(data)).toList();
}

class CityResponseModel {
  CityResponseModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    
  });
  late final int id;
  late final String name;
  late final String slug;
  late final String createdAt;
  late final String updatedAt;

  CityResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
