class TaskModel {
  int? id;
  String? name;
  String? detail;

  TaskModel({
    this.id,
    this.name,
    this.detail,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['detail'] = this.detail;
    return data;
  }
}
