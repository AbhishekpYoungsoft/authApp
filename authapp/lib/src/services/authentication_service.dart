// authentication_service.dart
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class AuthenticationService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    print("can authenicate bio: $canAuthenticateWithBiometrics");
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    print("does devide ssuppoer bio authenticate: $canAuthenticate");
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    print("Available bio options: $availableBiometrics");

    return canAuthenticate;
  }

  Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(useErrorDialogs: false),
      );

      return didAuthenticate;
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        // Handle case where the user has not enrolled any biometrics
          print("User has not enrolled any bio metrics on the device condition");
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        // Handle case where biometrics are locked
          print("UserApi temprorily blocked out");

      }else{
        print("Some unknown Error occured");
        return false;

      }
      // Handle other errors
      return false;
    }
  }
}
