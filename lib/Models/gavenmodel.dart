class Gavenmodel {
  int id;
  String name;
  String money;
  String note;
  String phone;
  String address;
  String date;

  Gavenmodel(
      {required this.id,
      required this.name,
      required this.money,
      required this.note,
      required this.phone,
      required this.address,
      required this.date});
  // @override
  // String toString() {
  //   return '\nناو: $name\nبڕی پارە: $money\nتێبینی: $note\nژ.م: $phone\nناونیشان: $address\nبەروار: $date';
  // }
  factory Gavenmodel.fromJson(Map<String, dynamic> json) {
    return Gavenmodel(
        id: json['id'],
        name: json['name'],
        money: json["money"],
        note: json["note"],
        phone: json["phone"],
        address: json["address"],
        date: json["date"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name.toString(),
      'Money': money.toString(),
      'Note': note.toString(),
      'Phone': phone.toString(),
      'Address': address.toString(),
      'Date': date.toString(),
    };
  }
}
