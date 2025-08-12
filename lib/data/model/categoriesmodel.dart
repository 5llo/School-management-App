// ignore_for_file: prefer_collection_literals

class CategoryModel {
  int? id;
  String? catName;
  String? image;
  String? updatedAt;

  CategoryModel({this.id, this.catName, this.image, this.updatedAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catName = json['cat_name'];
    image = json['image'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['cat_name'] = catName;
    data['image'] = image;
    data['updated_at'] = updatedAt;
    return data;
  }
}