class CartModal {
  int? id;
  String? name;
  int? price;
  String? image;
  int? quantity;
  bool? isExist;
  String? time;

  CartModal({
    this.id,
    this.name,
    this.price,
    this.image,
    this.quantity,
    this.isExist,
    this.time,
  });

  CartModal.fromJsom(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
  }
}
