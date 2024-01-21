import 'repository.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:developer';

class LoginRepository extends Repository {
  Future logout() async {
    final Dio dio = Dio();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('session') ?? "";
    Map fdataMap = {'session_token': sessionToken};
    FormData fdata = FormData();
    fdata.fields.addAll(fdataMap.entries.map((e) => MapEntry(e.key, e.value)));
    final response = await dio.post(
      'https://latihan-flutter.000webhostapp.com/logout.php',
      data: fdata,
    );
    prefs.remove('session_token');
  }

  Future login({required String username, required String password}) async {
    log("MASUK REPO");
    final Dio dio = Dio();
    Map fdataMap = {'user': username, 'pwd': password};
    FormData fdata = FormData();
    fdata.fields.addAll(fdataMap.entries.map((e) => MapEntry(e.key, e.value)));
    log("MAP DATA $fdataMap");
    final response = await dio.post(
      'https://latihan-flutter.000webhostapp.com/login.php',
      data: fdata,
    );
    log("res $response");
    Map reporesponse = {"status": false, "data": Null};
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.data);
      log("DATA STATUS " + data.toString());
      if (data['status'] == 'succes') {
        log("<MASUK KONDISI SUCCESS");
        reporesponse['status'] = true;
        reporesponse['data'] = data;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('session', data['session_token']);
        // reporesponse = {"status": true, "data": data};
      } else {
        reporesponse['data'] = data;
      }
    }
    return reporesponse;
  }
}
