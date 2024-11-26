class HomeModel {
  String title;
  int number;
  String no;

  HomeModel({
    required this.title,
    required this.number,
    required this.no,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      title: json['title'] as String,
      number: json['number'] as int,
      no: json['_No'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'number': number,
      '_No': no,
    };
  }
}
