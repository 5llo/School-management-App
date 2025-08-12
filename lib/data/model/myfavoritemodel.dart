// ignore_for_file: prefer_collection_literals

class MyFavoriteModel {
  int? id;
  String? prodName;
  String? description;
  String? image;
  int? count;
  int? active;
  String? price;
  String? discount;
  int? fav;
  int? categoryId;
  String? catName;
  String? categoryImage;

  MyFavoriteModel(
      {this.id,
      this.prodName,
      this.description,
      this.image,
      this.count,
      this.active,
      this.price,
      this.discount,
      this.fav,
      this.categoryId,
      this.catName,
      this.categoryImage});

  MyFavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prodName = json['prod_name'];
    description = json['description'];
    image = json['image'];
    count = json['count'];
    active = json['active'];
    price = json['price'];
    discount = json['discount'];
    fav = json['fav'];
    categoryId = json['category_id'];
    catName = json['cat_name'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['prod_name'] = prodName;
    data['description'] = description;
    data['image'] = image;
    data['count'] = count;
    data['active'] = active;
    data['price'] = price;
    data['discount'] = discount;
    data['fav'] = fav;
    data['category_id'] = categoryId;
    data['cat_name'] = catName;
    data['category_image'] = categoryImage;
    return data;
  }
}