import 'dart:async';

import 'package:coba/model/person.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart';

enum PersonState { loading, noData, hasData, error }

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;

  NewsProvider({required this.apiService}) {
    _fetchAllArticle();
  }

  late Person _person;
  late PersonState _state;
  String _message = ' ';

  String get message => _message;

  Person get result => _person;

  PersonState get state => _state;

  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = PersonState.loading;
      notifyListeners();
      final person1 = await apiService.personList();
      if (person1.result.isEmpty) {
        _state = PersonState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = PersonState.hasData;
        notifyListeners();
        return _person = person1;
      }
    } catch (e) {
      _state = PersonState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
