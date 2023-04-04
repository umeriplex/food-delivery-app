class SignUpBody{
  String? name;
  String? email;
  String? password;
  String? phone;

  SignUpBody({this.name, this.email, this.password, this.phone});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    name = json['f_name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['f_name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}