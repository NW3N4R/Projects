
class Donatedprofilesmodel {
  int id;
  String Name;
  String Address;
  String Phone;

  Donatedprofilesmodel(
      {required this.id,
      required this.Name,
      required this.Address,
      required this.Phone});
  @override
  String toString() {
    return 'ناو: $Name\nژ.م: $Phone\nناونیشان: $Address';
  }
  factory Donatedprofilesmodel.fromJson(Map<String, dynamic> json) {
    return Donatedprofilesmodel(
        id: json['id'],
        Name: json['name'],
        Phone: json["phone"],
        Address: json["address"]);
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': Name.toString(),
      'phone': Phone.toString(),
      'address': Address.toString(),
    };
  }
}
