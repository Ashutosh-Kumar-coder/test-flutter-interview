// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

class InfoModel {
  InfoModel({
  required  this.id,
    required this.name,
    required this.image,
  });

  String id;
  String name;
  String image;

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
