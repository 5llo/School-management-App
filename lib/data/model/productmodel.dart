class ProductModel {
  int? id;
  String? prodName;
  String? description;
  String? image;
  int? count;
  int? active;
  String? price;
  int? discount;
  int ?pricewithdiscount;
  int? categoryId;
  String? catName;
  String? categoryImage;
  int? fav;

  ProductModel(
      {this.id,
      this.prodName,
      this.description,
      this.image,
      this.count,
      this.active,
      this.price,
      this.discount,
      this.pricewithdiscount,
      this.categoryId,
      this.catName,
      this.categoryImage,
      this.fav
      });


  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prodName = json['prod_name'];
    description = json['description'];
    image = json['image'];
    count = json['count'];
    active = json['active'];
    price = json['price'];
    discount = json['discount'];
    pricewithdiscount = json['price_after_discount'];
    categoryId = json['category_id'];
    catName = json['cat_name'];
    categoryImage = json['category_image'];
    fav=json['fav'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['prod_name'] = prodName;
    data['description'] = description;
    data['image'] = image;
    data['count'] = count;
    data['active'] = active;
    data['price'] = price;
    data['discount'] = discount;
    data['price_after_discount'] = pricewithdiscount;
    data['category_id'] = categoryId;
    data['cat_name'] = catName;
    data['category_image'] = categoryImage;
    data['fav'] = fav;
    return data;
  }

}