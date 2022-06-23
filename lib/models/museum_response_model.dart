import 'dart:convert';

MuseumResponseModel museumResponseJson(String str) =>
    MuseumResponseModel.fromJson(json.decode(str));

class MuseumResponseModel {
  MuseumResponseModel({
    required this.id,
    required this.city_id,
    required this.name,
    required this.slug,
    required this.image,
    required this.excerpt,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
    
  });
  late final int id;
  late final int city_id;
  late final String name;
  late final String slug;
  late final String image;
  late final String excerpt;
  late final String desc;
  late final String createdAt;
  late final String updatedAt;

  MuseumResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city_id = json['city_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    excerpt = json['excerpt'];
    desc = json['desc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['city_id'] = city_id;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['image'] = image;
    _data['excerpt'] = excerpt;
    _data['desc'] = desc;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
