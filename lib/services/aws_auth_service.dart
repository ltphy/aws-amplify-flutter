import 'package:amplify_flutter/amplify_flutter.dart';

abstract class Auth {
  Future<bool> isSignedIn();

  Future<void> signOut();

  Future<String> getCurrentUser();
}

class AWSAuthService extends Auth {

  @override
  Future<String> getCurrentUser() async {
    try {
      final response = await Amplify.Auth.getCurrentUser();
      return response.username;
    } on AmplifyException catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    final session = await Amplify.Auth.fetchAuthSession();
    return session.isSignedIn;
  }

  @override
  Future<void> signOut() async {
    // TODO: implement signOut
    try {
      await Amplify.Auth.signOut();
    } on AmplifyException catch (e) {
      rethrow;
    }
  }
}
