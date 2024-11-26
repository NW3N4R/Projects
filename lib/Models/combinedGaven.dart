// ignore_for_file: file_names

import 'package:garmian_house_of_charity/Models/gavenautosets.dart';
import 'package:garmian_house_of_charity/Models/gavenmodel.dart';
class Combinedgaven {
  // ignore: non_constant_identifier_names
  Gavenmodel Gaven;
  // ignore: non_constant_identifier_names
  GavenAutoSet AutoTimeSet;

  Combinedgaven({
      // ignore: non_constant_identifier_names
    required this.Gaven,

 // ignore: non_constant_identifier_names
    required this.AutoTimeSet,
  });

  // Convert the combined model to JSON
  Map<String, dynamic> toJson() {
    return {
      'Gaven': Gaven.toJson(),
      'AutoTimeSet': AutoTimeSet.toJson(),
    };
  }

  // Create a Gaven instance from JSON
  factory Combinedgaven.fromJson(Map<String, dynamic> json) {
    return Combinedgaven(
      Gaven: Gavenmodel.fromJson(json['Gaven']),
      AutoTimeSet: GavenAutoSet.fromJson(json['AutoTimeSet']),
    );
  }
}
