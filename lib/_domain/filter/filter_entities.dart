import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:flutter/cupertino.dart';

@immutable
class FillingFilterEntity {
  final List<String> categories;
  final List<String> ingredients;
  final List<String> alcoholPresence;

  const FillingFilterEntity({
    required this.categories,
    required this.ingredients,
    required this.alcoholPresence,
  });
}

@immutable
class ApllyingFilterEntity {
  final String? name;
  final String? category;
  final List<String>? ingredients;
  final AlcoholPresence? alcoholPresence;

  const ApllyingFilterEntity({
    this.name,
    this.category,
    this.ingredients,
    this.alcoholPresence,
  });
}
