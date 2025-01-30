import 'package:garmian_house_of_charity/Models/autotimesetmodel.dart';
import 'package:garmian_house_of_charity/Models/donatedprofilesmodel.dart';
import 'package:garmian_house_of_charity/Models/donationhistorymodel.dart';

class ProfileCombinedModel {
  final Donatedprofilesmodel donatedProfiles;
  final DonationHistoryModel donationHistory;
  final AutoTimeSetsModel autoTimeSets;

  ProfileCombinedModel({
    required this.donatedProfiles,
    required this.donationHistory,
    required this.autoTimeSets,
  });

  factory ProfileCombinedModel.fromJson(Map<String, dynamic> json) {
    return ProfileCombinedModel(
      donatedProfiles: Donatedprofilesmodel.fromJson(json['DonatedProfiles']),
      donationHistory: DonationHistoryModel.fromJson(json['DonationHistory']),
      autoTimeSets: AutoTimeSetsModel.fromJson(json['AutoTimeSets']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DonatedProfiles': donatedProfiles.toJson(),
      'DonationHistory': donationHistory.toJson(),
      'AutoTimeSets': autoTimeSets.toJson(),
    };
  }
}