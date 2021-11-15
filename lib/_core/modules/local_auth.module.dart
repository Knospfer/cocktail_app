import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@module
abstract class RegisterAuthProvider {
  @lazySingleton
  LocalAuthentication auth() => LocalAuthentication();
}
