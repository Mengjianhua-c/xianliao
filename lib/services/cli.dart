import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import './cache/sql_util.dart';
import './cache/local_storage.dart';


// 或者通过传递一个 `options`来创建dio实例
BaseOptions options = BaseOptions(
  baseUrl: "http://39.105.167.167:80",
  connectTimeout: 5000,
  receiveTimeout: 3000,
  responseType: ResponseType.json,
  headers: {},
);

initOptions() async {
  var auth = await AuthInfo().getInfo();
  if(auth!=null){
    print('use storage cache$auth');
    options.headers['Authorization'] = auth;
  }else{
    var userInfo = await DbUtil.getUser();
    if (userInfo!=null){
      print('init Authorization: ${userInfo.toJson()}');
      options.headers['Authorization'] = userInfo.assessKey;
    }else{
      print('init headers failed');
    }
  }
}

Dio dio = Dio(options);

class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    var params;
    if (options.method == 'GET'){
      params = options.queryParameters;
    }else{
      params = options.data;
    }
    print(
        "REQUEST[${options?.method}] => PATH: ${options?.path} => PARAMS:$params | headers:${options.headers}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print("RESPONSE[${response?.statusCode}] => RESPONSE: ${response?.data}");
    if (response.data['code'] != 0) {
      BotToast.showText(text: "${response.data['message']}");
    }
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print(
        "ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path} => VALUE: ${err?.toString()}");
    BotToast.showText(text: "请求失败！错误信息:${err?.toString()}");
    return super.onError(err);
  }
}

class ApiPath {
  String topicList = "/x/topic/list";
  String topicDetail = '/x/topic/detail';
  String topicLike = '/x/topic/like';

  String avatarUrl(int userId) {
    return "${dio.options.baseUrl}/x/user/avatar.png?id=$userId";
  }

  String userInfo = '/x/user';
  String login = '/x/login';

  String diskPath = '/x/path'; //folder_path

}
