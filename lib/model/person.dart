import 'dart:convert';

class Person {
  String message;
  List<Result> result;

  Person({
    required this.message,
    required this.result,
  });


  factory Person.fromJson(Map<String, dynamic> json) => Person(
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  int rank;
  String namePerson;
  String name;
  int point;

  Result({
    required this.rank,
    required this.namePerson,
    required this.name,
    required this.point,
  });


  factory Result.fromJson(Map<String, dynamic> json) => Result(
    rank: json["rank"],
    namePerson: json["name_person"],
    name: json["name"],
    point: json["point"],
  );

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "name_person": namePerson,
    "name": name,
    "point": point,
  };
}

class PersonSolo {
  final int rank;
  final String name_person;
  final String city_id;
  final String point;

  PersonSolo({
    required this.rank,
    required this.name_person,
    required this.city_id,
    required this.point,
  });


  factory PersonSolo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {

      'rank' : int rank,
      'name_person' : String name_person,
      'city_id' : String city_id,
      'point' : String point,
      } =>
          PersonSolo(
            rank :  rank,
            name_person :  name_person,
            city_id :  city_id,
            point :  point,
          ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}