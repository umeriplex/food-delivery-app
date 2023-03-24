class Product{
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModal> _products;
  List<ProductModal> get products => _products;

  Product({required totalSize, required typeId, required offset, required products}){
    _totalSize = totalSize;
    _typeId = typeId;
    _offset = offset;
    _products = products;
  }

  Product.fromJson(Map<String,dynamic> json ){
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if(json["products"] != null){
      _products = <ProductModal>[];
      for (var e in (json["products"] as List)) {
        _products.add(ProductModal.fromJsom(e));
      }
    }
  }

}


class ProductModal{
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? image;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductModal({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stars,
    this.image,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.typeId,
  });

  ProductModal.fromJsom(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    image = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['stars'] = stars;
    data['img'] = image;
    data['location'] = location;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type_id'] = typeId;
    return data;
  }


}