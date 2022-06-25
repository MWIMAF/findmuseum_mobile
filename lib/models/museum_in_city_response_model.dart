import "dart:convert";

List<MuseumInCityResponseModel> museumInCityResponseModelJson(str) {
  List jsonResponse = json.decode(str);
  return jsonResponse
      .map((data) => MuseumInCityResponseModel.fromJson(data))
      .toList();
}

class MuseumInCityResponseModel {
  int? id;
  int? cityId;
  String? name;
  String? slug;
  String? image;
  String? excerpt;
  String? desc;
  String? createdAt;
  String? updatedAt;

  MuseumInCityResponseModel(
      {this.id,
      this.cityId,
      this.name,
      this.slug,
      this.image,
      this.excerpt,
      this.desc,
      this.createdAt,
      this.updatedAt});

  MuseumInCityResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    excerpt = json['excerpt'];
    desc = json['desc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['city_id'] = cityId;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    data['excerpt'] = excerpt;
    data['desc'] = desc;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
