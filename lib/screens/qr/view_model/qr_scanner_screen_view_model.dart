import 'package:cocktail_app/_domain/cocktail/entity/cocktail_entity.dart';
import 'package:cocktail_app/_domain/cocktail/services/cocktail.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class QrScannerScreenViewModel extends ChangeNotifier {
  final CocktailService _cocktailService;

  QrScannerScreenViewModel(this._cocktailService);

  Future<CocktailEntity?> findByIdsFromQRScan(String qr) async {
    if (int.tryParse(qr) == null) return null; //TODO GESTIONE ERRORI
    return _cocktailService.findElementBy(qr);
  }
}
