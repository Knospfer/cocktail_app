import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@injectable
class LoginViewModel extends ChangeNotifier {
  final LocalAuthentication _auth;

  LoginViewModel(this._auth);

  Future<bool> authenticate() async {
    try {
      return _auth.authenticate(
        localizedReason: 'Authenticate to discover some new cocktail ;)',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (_) {
      return false; //TODO GESTIONE ERRORI
    }
  }
}
