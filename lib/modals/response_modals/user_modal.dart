class UserModal {
  int id;
  String name;
  String email;
  String phone;
  int orderCount;

  UserModal({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.orderCount,
  });

  factory UserModal.fromJson(Map<String, dynamic> json) {
    return UserModal(
      id: json['id'],
      name: json['f_name'],
      email: json['email'],
      phone: json['phone'],
      orderCount: json['order_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['f_name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['order_count'] = orderCount;
    return data;
  }
}
