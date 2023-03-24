import 'package:food_odering_app/modals/popular_product_response_modal.dart';

class CartModal {
  int? id;
  String? name;
  int? price;
  String? image;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModal? product;

  CartModal({
    this.id,
    this.name,
    this.price,
    this.image,
    this.quantity,
    this.isExist,
    this.time,
    this.product,
  });

  CartModal.fromJsom(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = ProductModal.fromJsom(json['product']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['img'] = image;
    data['quantity'] = quantity;
    data['isExist'] = isExist;
    data['time'] = time;
    data['product'] = product!.toJson();
    return data;
  }
}
