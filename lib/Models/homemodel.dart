class HomeModel {
  String title;
  double number;
  String no;

  HomeModel({
    required this.title,
    required this.number,
    required this.no,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      title: json['title'] as String,
      number:  (json['number'] as num).toDouble(),
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
