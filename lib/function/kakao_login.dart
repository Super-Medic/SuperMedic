import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:super_medic/function/LoginVerify.dart';
import 'package:super_medic/function/model.dart';

class KakaoLogin {
  Login_verify loginverify = Login_verify();
  // ignore: non_constant_identifier_names
  Future<String> get_user_join(
      phnoe, telecom, fristNumber, secondNumber, name) async {
    try {
      User user = await UserApi.instance.me();
      final response = await http.post(
        Uri.https('mypd.kr:5000', '/user/join'),
        body: {
          "name": name,
          "account_email": user.kakaoAccount?.email,
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
          OAuthToken? token =
              await TokenManagerProvider.instance.manager.getToken();
          var val = jsonEncode(LoginModel(
              'Kakao',
              token!.accessToken,
              token.refreshToken as String,
              user.kakaoAccount?.email as String,
              name,
              phnoe,
              telecom.substring(0, 1),
              fristNumber,
              secondNumber));
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

  Future<String> signInWithKakao() async {
    print(await KakaoSdk.origin);
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        try {
          User user = await UserApi.instance.me();
          final verify =
              await loginverify.Loginverify(user.kakaoAccount?.email as String);
          return verify;
        } catch (err) {
          return 'false_err';
        }
      } catch (error) {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          try {
            User user = await UserApi.instance.me();
            final verify = await loginverify.Loginverify(
                user.kakaoAccount?.email as String);
            return verify;
          } catch (err) {
            return 'false_err';
          }
        } catch (error) {
          return 'false_err';
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        try {
          User user = await UserApi.instance.me();
          final verify =
              await loginverify.Loginverify(user.kakaoAccount?.email as String);
          return verify;
        } catch (err) {
          return 'false_err';
        }
      } catch (error) {
        return 'false_err';
      }
    }
  }

  Future<String> signOutWithKakao() async {
    try {
      await UserApi.instance.logout();
      return 'true';
    } catch (err) {
      return 'false';
    }
  }

  //Token 검증
  Future<bool> KakaoTokenVerifiy(dynamic val) async {
    OAuthToken? token = await TokenManagerProvider.instance.manager.getToken();
    if (token != null) {
      return true;
    }
    // if (val.reflashToken == token!.refreshToken){
    //   if(val.accessToken != token.accessToken){

    //   }

    // } else if (val.accessToken == token.accessToken){

    // }
    return false;
  }

  Future<bool> KakaoLoginBeing() async {
    OAuthToken? token = await TokenManagerProvider.instance.manager.getToken();
    User user = await UserApi.instance.me();
    try {
      final response = await http.post(
        Uri.https('mypd.kr:5000', '/user/loginselect'),
        body: {"account_email": user.kakaoAccount!.email},
      );
      LoginBeingModel value =
          LoginBeingModel.fromJson(json.decode(response.body));
      const storage = FlutterSecureStorage();
      var val = jsonEncode(LoginModel(
          'Kakao',
          token!.accessToken,
          token.refreshToken as String,
          user.kakaoAccount?.email as String,
          value.name,
          value.phone_number,
          value.telecom,
          value.birthday,
          value.gender.toString()));
      await storage.write(key: 'LoginUser', value: val);
      return true;
    } catch (error) {
      return false;
    }
  }
}
