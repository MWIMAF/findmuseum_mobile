class EditUserRequestModel {
  String? name;
  String? username;
  String? email;

  EditUserRequestModel({
    this.name,
    this.username,
    this.email,
  });

  EditUserRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }
}
