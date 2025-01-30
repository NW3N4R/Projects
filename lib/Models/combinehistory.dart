// Define the CombinedModel that holds properties of both models
import 'package:garmian_house_of_charity/Models/autotimesetmodel.dart';
import 'package:garmian_house_of_charity/Models/donationhistorymodel.dart';

class CombinedHistories {
  final DonationHistoryModel History;
  final AutoTimeSetsModel autoTimeSets;

  CombinedHistories({
    required this.History,
    required this.autoTimeSets,
  });

  // Add a method to convert the CombinedModel to a map (optional)
  Map<String, dynamic> toJson() {
    return {
      'histories': History.toJson(),
      'timeSets': autoTimeSets.toJson(),
    };
  }

  // A method to create an instance of CombinedModel from a map (optional)
  factory CombinedHistories.fromJson(Map<String, dynamic> map) {
    return CombinedHistories(
      History: DonationHistoryModel.fromJson(map['histories']),
      autoTimeSets: AutoTimeSetsModel.fromJson(map['timeSets']),
    );
  }
}
