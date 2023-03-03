// ignore: file_names
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Login_verify {
  // ignore: non_constant_identifier_names
  Future<String> Loginverify(String email) async {
    try {
      final response = await http.post(
        Uri.https('mypd.kr:5000', '/user/joinverify'),
        body: {"account_email": email},
      );
      return response.body;
    } catch (error) {
      return "false_err";
    }
  }

  Future<String> userSecession(String email) async {
    try {
      final response = await http.post(
        Uri.https('mypd.kr:5000', '/user/secession'),
        body: {"account_email": email},
      );
      return response.body;
    } catch (error) {
      return "false_err";
    }
  }

  Future<String> userSelect(String email) async {
    try {
      final response = await http.post(
        Uri.https('mypd.kr:5000', '/user/loginselect'),
        body: {"account_email": email},
      );
      return response.body;
    } catch (error) {
      return "false_err";
    }
  }
}
