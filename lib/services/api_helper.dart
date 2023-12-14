import 'dart:convert';

import 'package:api_train/model/test_api_model.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper{
  static String baseUrl = "https://randomuser.me/api/";

  Future<TestApiModel> getTestApiResultSingle() async {
    final res = await http.get(Uri.parse(baseUrl));
    var data = jsonDecode(res.body);
    TestApiModel testApiModel = TestApiModel();
    if(res.statusCode == 200){
      testApiModel = TestApiModel.fromJson(data);
      testApiModel.errorMessage = "no Error";
      return testApiModel;
    } else {
      testApiModel.errorMessage = "Error Occurred";
      return testApiModel;
    }
  }

  Future<TestApiModel> getTestApiResultMultiple(String resultCount) async {
    final res = await http.get(Uri.parse("$baseUrl?results=$resultCount"));
    var data = jsonDecode(res.body);
    TestApiModel testApiModel = TestApiModel();
    if(res.statusCode == 200){
      testApiModel = TestApiModel.fromJson(data);

      testApiModel.errorMessage = "no Error";
      return testApiModel;
    } else {
      testApiModel.errorMessage = "Error Occurred";
      return testApiModel;
    }
  }
}