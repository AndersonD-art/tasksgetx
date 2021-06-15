import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.id,
    required this.name,
    required this.date,
  });

  int? id;
  String name;
  String date;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        id: json["id"],
        name: json["name"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date,
      };
}
