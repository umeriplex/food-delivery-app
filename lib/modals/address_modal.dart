class AddressModal{
  late int? _id;
  late String _addressType;
  late String? _contactPersonUserName;
  late String? _contactPersonNumber;
  late String _address;
  late String _lati;
  late String _longi;
  AddressModal({id, required addressType, contactPersonUserName, contactPersonNumber, address, lati, longi,}){
  _id = id;
  _addressType = addressType;
  _contactPersonUserName = contactPersonUserName;
  _contactPersonNumber = contactPersonNumber;
  _address = address;
  _lati = lati;
  _longi = longi;
  }

  String get longi => _longi;
  String get lati => _lati;
  String get address => _address;
  String? get contactPersonNumber => _contactPersonNumber;
  String? get contactPersonUserName => _contactPersonUserName;
  String get addressType => _addressType;

  AddressModal.fromJson(Map<String, dynamic> json){
  _id = json['id'];
  _addressType = json['address_type'] ?? "";
  _contactPersonUserName = json['contact_person_user_name'] ?? "";
  _contactPersonNumber = json['contact_person_number'] ?? "";
  _address = json['address'];
  _lati = json['latitude'];
  _longi = json['longitude'];
  }

  Map<String, dynamic> toJson(){
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this._id;
  data['address_type'] = this._addressType;
  data['contact_person_name'] = this._contactPersonUserName;
  data['contact_person_number'] = this._contactPersonNumber;
  data['address'] = this._address;
  data['longitude'] = this._longi;
  data['latitude'] = this._lati;
  return data;
  }
}
