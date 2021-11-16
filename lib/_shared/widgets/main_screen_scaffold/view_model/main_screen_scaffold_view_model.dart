import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainScreenScaffoldViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoadingState(bool state) {
    _isLoading = state;
    notifyListeners();
  }
}
