class GavenAutoSet {
  String date;
  String time;
  String day;

  // Constructor to initialize the class properties
  GavenAutoSet({
    required this.date,
    required this.time,
    required this.day,
  });

  // Convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'Date': date,
      'Time': time,
      'Day': day,
    };
  }

  factory GavenAutoSet.fromJson(Map<String, dynamic> json) {
    return GavenAutoSet(
      date: json['Date'],
      time: json['Time'],
      day: json['Day'],
    );
  }
}