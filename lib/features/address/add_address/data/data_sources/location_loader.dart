import 'dart:convert';
import 'package:flutter/services.dart';

class GovernorateModel {
  final String id;
  final String nameEn;
  final String nameAr;

  GovernorateModel({required this.id, required this.nameEn, required this.nameAr});

  factory GovernorateModel.fromJson(Map<String, dynamic> json) {
    return GovernorateModel(
      id: json['id'].toString(),
      nameEn: json['governorate_name_en'],
      nameAr: json['governorate_name_ar'],
    );
  }
}

class CityModel {
  final String id;
  final String governorateId;
  final String nameEn;
  final String nameAr;

  CityModel({
    required this.id,
    required this.governorateId,
    required this.nameEn,
    required this.nameAr,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'].toString(),
      governorateId: json['governorate_id'].toString(),
      nameEn: json['city_name_en'],
      nameAr: json['city_name_ar'],
    );
  }
}

class LocationDataLoader {
  static List<GovernorateModel>? _governorates;
  static List<CityModel>? _cities;

  /// Loads and caches both files. Call once (e.g. in initState).
  static Future<void> load() async {
    if (_governorates != null && _cities != null) return;

    final govString = await rootBundle.loadString('assets/data/cities.json');
    final cityString = await rootBundle.loadString('assets/data/states.json');

    final govJson = jsonDecode(govString) as List;
    final cityJson = jsonDecode(cityString) as List;

    // Find the "table" entry whose name matches, then read its "data" list.
    final govTable = govJson.firstWhere(
          (e) => e['type'] == 'table' && e['name'] == 'governorates',
    );
    final cityTable = cityJson.firstWhere(
          (e) => e['type'] == 'table' && e['name'] == 'cities',
    );

    _governorates = (govTable['data'] as List)
        .map((e) => GovernorateModel.fromJson(e))
        .toList();

    _cities = (cityTable['data'] as List)
        .map((e) => CityModel.fromJson(e))
        .toList();
  }

  static List<GovernorateModel> get governorates => _governorates ?? [];

  /// Returns cities belonging to the given governorate id.
  static List<CityModel> citiesFor(String governorateId) {
    return (_cities ?? [])
        .where((c) => c.governorateId == governorateId)
        .toList();
  }
}