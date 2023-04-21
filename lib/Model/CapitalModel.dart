// To parse this JSON data, do
//
//     final capitalModel = capitalModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

// To parse this JSON data, do
//
//     final capitalModel = capitalModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CapitalModel> capitalModelFromJson(String str) => List<CapitalModel>.from(json.decode(str).map((x) => CapitalModel.fromJson(x)));

String capitalModelToJson(List<CapitalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CapitalModel {
  CapitalModel({
    required this.name,
    required this.capital,
  });

  final Name name;
  final List<String> capital;

  factory CapitalModel.fromJson(Map<String, dynamic> json) => CapitalModel(
    name: Name.fromJson(json["name"]),
    capital: List<String>.from(json["capital"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name.toJson(),
    "capital": List<dynamic>.from(capital.map((x) => x)),
  };
}

class Name {
  Name({
    required this.common,
    required this.official,
    required this.nativeName,
  });

  final String common;
  final String official;
  final Map<String, NativeName> nativeName;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    common: json["common"],
    official: json["official"],
    nativeName: Map.from(json["nativeName"]).map((k, v) => MapEntry<String, NativeName>(k, NativeName.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "common": common,
    "official": official,
    "nativeName": Map.from(nativeName).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class NativeName {
  NativeName({
    required this.official,
    required this.common,
  });

  final String official;
  final String common;

  factory NativeName.fromJson(Map<String, dynamic> json) => NativeName(
    official: json["official"],
    common: json["common"],
  );

  Map<String, dynamic> toJson() => {
    "official": official,
    "common": common,
  };
}
