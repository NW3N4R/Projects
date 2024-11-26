class Partialmodel{
int id;
  String name;
  String phone;
  String city;
  String alley;
  String house;
  String carer;
  String famNo;
  String note;
  String tag;

  // Constructor to initialize the class
  Partialmodel({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.alley,
    required this.house,
    required this.carer,
    required this.famNo,
    required this.note,
    required this.tag,
  });
    factory Partialmodel.fromJson(Map<String, dynamic> json) {
    return Partialmodel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      city: json['city'],
      alley: json['alley'],
      house: json['house'],
      carer: json['carer'],
      famNo: json['famNo'],
      note: json['note'],
      tag: json['tag'],
    );
  }
}