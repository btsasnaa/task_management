class RegisterModel {
  String? name;
  String? detail;

  RegisterModel({
    this.name,
    this.detail,
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['detail'] = this.detail;
    return data;
  }
}
