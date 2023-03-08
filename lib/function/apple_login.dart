import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/LoginVerify.dart';
import 'package:super_medic/function/model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLogin {
  Login_verify loginverify = Login_verify();
  //ignore: non_constant_identifier_names
  Future<String> get_user_join(
      phnoe, telecom, fristNumber, secondNumber, name, credential) async {
    try {
      final response = await http.post(
        Uri.https('mypd.kr:5000', '/user/join'),
        body: {
          "name": name,
          "account_email": credential.email != null
              ? credential.email
              : JwtDecode(credential),
          "phone": phnoe,
          "telecom": telecom.substring(0, 1),
          "birthday": fristNumber,
          "gender": secondNumber,
        },
      );
      // ignore: unrelated_type_equality_checks
      if (response.body == 'true') {
        try {
          const storage = FlutterSecureStorage();
          var val = jsonEncode(LoginModel(
              'Apple',
              credential.userIdentifier,
              credential.identityToken as String,
              credential.email != null
                  ? credential.email
                  : JwtDecode(credential),
              name,
              phnoe,
              telecom.substring(0, 1),
              fristNumber,
              secondNumber));
          print(val);
          await storage.write(key: 'LoginUser', value: val);
          return 'true';
        } catch (err) {
          return 'false';
        }
      } else {
        return 'false';
      }
    } catch (error) {
      return 'false';
    }
  }

  Future<dynamic> signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: "27FNKD8V57.superMedic.com",
          redirectUri: Uri(
            scheme: 'https',
            host: 'mypd.kr',
            port: 5000,
            path: '/user/apple/callbacks/sign_in_with_apple',
          ),
        ),
      );

      // print('credential = $credential');
      // print('credential.state = ${credential.state}');
      // print('credential.email = ${credential.email}');
      // print('credential.identityToken = ${credential.identityToken}');
      // print('credential.userIdentifier = ${credential.userIdentifier}');
      // print('credential.email using decode = ${await JwtDecode(credential)}');
      // final credentialState =
      //     await SignInWithApple.getCredentialState(credential.userIdentifier!);
      // print(credentialState);

      // final signInWithAppleEndpoint = Uri(
      //   scheme: 'https',
      //   host: 'mypd.kr',
      //   port: 5000,
      //   path: '/user/apple/sign_in_with_apple',
      //   queryParameters: <String, String>{
      //     'code': credential.authorizationCode,
      //     if (credential.email != null) 'email': credential.email!,
      //     if (credential.userIdentifier != null)
      //       'userIdentifier': credential.userIdentifier!,
      //     if (credential.state != null) 'state': credential.state!,
      //   },
      // );

      // final session = await http.Client().post(
      //   signInWithAppleEndpoint,
      // );
      // print(session);

      return credential;
    } catch (error) {
      print('error = $error');
      return 'false';
    }
  }

  Future<int> AppleUidVerifiy2(dynamic val) async {
    final credentialState =
        await SignInWithApple.getCredentialState(val.userIdentifier!);
    switch (credentialState) {
      case CredentialState.authorized:
        return 0;
      case CredentialState.revoked:
        return 1;
      case CredentialState.notFound:
        return 2;
    }
  }

  Future<int> AppleUidVerifiy(dynamic val) async {
    final credentialState =
        await SignInWithApple.getCredentialState(val.accessToken);
    switch (credentialState) {
      case CredentialState.authorized:
        return 0;
      case CredentialState.revoked:
        return 1;
      case CredentialState.notFound:
        return 2;
    }
  }

  String JwtDecode(credential) {
    List<String> jwt = credential.identityToken?.split('.') ?? [];
    String payload = jwt[1];
    payload = base64.normalize(payload);

    final List<int> jsonData = base64.decode(payload);
    final userInfo = jsonDecode(utf8.decode(jsonData));
    // print(userInfo);
    return userInfo['email'];
  }
}
