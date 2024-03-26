import 'dart:convert';

class City {
  String message;
  List<Resultcity> result;

  City({
    required this.message,
    required this.result,
  });
  factory City.fromJson(Map<String, dynamic> json) => City(
    message: json["message"],
    result: List<Resultcity>.from(json["result"].map((x) => Resultcity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}


class Resultcity {
  int id;
  String name;

  Resultcity({
    required this.id,
    required this.name,
  });


  factory Resultcity.fromJson(Map<String, dynamic> json) => Resultcity(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
