
class AutoTimeSetsModel {
  final int id;
  final int pid;
  final String? day;
  final DateTime autoDate;

  AutoTimeSetsModel({
    required this.id,
    required this.pid,
    this.day,
    required this.autoDate,
  });

  // Factory constructor to create a model instance from JSON
  factory AutoTimeSetsModel.fromJson(Map<String, dynamic> json) {

    return AutoTimeSetsModel(
      id: json['id'],
      pid: json['pid'],
      day: json['day'] as String?,
      autoDate: DateTime.parse(json['autoDate']),
    );
  }

  // Method to convert the model instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pid': pid,
      'day': day,
      'autoDate':
          autoDate.toIso8601String().split('T')[0], // Keeps only the date part
    };
  }
}
