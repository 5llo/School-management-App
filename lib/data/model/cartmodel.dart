class CartModel {
  int? productId;
  String? prodName;
  String? description;
  String? image;
  int? count;
  int? active;
  String? price;
  int? discount;
  int? quantity;
  String? allprice;
  String? createdAt;

  CartModel(
      {this.productId,
      this.prodName,
      this.description,
      this.image,
      this.count,
      this.active,
      this.price,
      this.discount,
      this.quantity,
      this.allprice,
      this.createdAt});

  CartModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    prodName = json['prod_name'];
    description = json['description'];
    image = json['image'];
    count = json['count'];
    active = json['active'];
    price = json['price'];
    discount = json['discount'];
    quantity = json['quantity'];
    allprice = json['allprice'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['prod_name'] = prodName;
    data['description'] = description;
    data['image'] = image;
    data['count'] = count;
    data['active'] = active;
    data['price'] = price;
    data['discount'] = discount;
    data['quantity'] = quantity;
    data['allprice'] = allprice;
    data['created_at'] = createdAt;
    return data;
  }
}