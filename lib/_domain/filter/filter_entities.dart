import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:flutter/cupertino.dart';

@immutable
class FilterDataEntity {
  final List<String> categories;
  final List<String> ingredients;
  final List<String> alcoholPresence;

  const FilterDataEntity({
    required this.categories,
    required this.ingredients,
    required this.alcoholPresence,
  });
}

class ApllyingFilterEntity {
  String? name;
  String? category;
  List<String>? ingredients;
  AlcoholPresence? alcoholPresence;

  ApllyingFilterEntity({
    this.name,
    this.category,
    this.ingredients,
    this.alcoholPresence,
  });
}
