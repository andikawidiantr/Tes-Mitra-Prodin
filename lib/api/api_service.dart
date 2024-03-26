import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/city.dart';
import '../model/person.dart';

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:8000/api/';

  Future<Person> personList() async {
    final response = await http.get(Uri.parse("${_baseUrl}person"));
    if (response.statusCode == 200) {
      return Person.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Connect');
    }
  }

  Future<City> cityList() async {
    final response = await http.get(Uri.parse("${_baseUrl}city"));
    if (response.statusCode == 200) {
      return City.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<PersonSolo> createPerson(String name_person, String city_id, String point) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}add-person'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name_person' : name_person,
        'city_id' : city_id,
        'point' : point,
      }),
    );

    if (response.statusCode == 201) {
      return PersonSolo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create person.');
    }
  }

  Future<Person> deletePerson(int rank) async {
    final response = await http.get(Uri.parse("${_baseUrl}deleteperson/$rank"));
    if (response.statusCode == 200) {
      return Person.fromJson(json.decode(response.body));
    } else {
      throw Exception('Item Not Deleted!');
    }
  }

}
