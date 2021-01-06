import 'dart:async';
import 'dart:io';
import 'package:xianliao/models/topic/topic_detail_entity.dart';

import 'api.dart';
import 'cli.dart';
import 'dart:convert';
import 'package:xianliao/models/movie.dart';
import 'package:xianliao/models/topic/topics_list_entity.dart';
import 'package:xianliao/models/user/login_entity.dart';
import 'package:xianliao/models/user/user_info_entity.dart';
import 'package:xianliao/models/cli_base_entity.dart';
import 'package:xianliao/models/cloud_disk/disk_path_entity.dart';


class RealAPI extends API {
  @override
  Future<MovieEnvelope> getMovieList(int start) async {
    var client = HttpClient();
    var request = await client.getUrl(Uri.parse(
        'https://api.douban.com/v2/movie/top250?start=$start&count=40'));
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    print(responseBody);
    Map data = json.decode(responseBody);
    return MovieEnvelope.fromJSON(data);
  }

  @override
  Future<Movie> getMovie(String movieID) async {
    var client = HttpClient();
    var request = await client
        .getUrl(Uri.parse('https://api.douban.com/v2/movie/subject/$movieID'));
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    Map data = json.decode(responseBody);
    return Movie.fromJSON(data);
  }

  Future<TopicsListEntity> getTopicsList(int page) async {
    var response = await dio.get(ApiPath().topicList,
        queryParameters: {"page": page, "pn": 15, "type": "all"});
    return TopicsListEntity().fromJson(response.data);
  }
  
  Future<TopicDetailEntity> getTopicDetail(int id) async {
    var response = await dio.post(ApiPath().topicDetail, data: {"id":id});
    return TopicDetailEntity().fromJson(response.data);
  }

  Future<LoginEntity> login(String username, String password) async {
    var response = await dio.post(ApiPath().login, data: {"username":username,"password":password});
    return LoginEntity().fromJson(response.data);
  }

  Future<UserInfoEntity> getUserInfo() async {
    var response = await dio.get(ApiPath().userInfo);
    return UserInfoEntity().fromJson(response.data);
  }

  Future<CliBaseEntity> topicLike(int topicId) async {
    var response = await dio.post(ApiPath().topicLike, data: {'id': topicId});
    return CliBaseEntity().fromJson(response.data);
  }

  Future<DiskPathEntity> getDiskPath(String path) async {
    var resp = await dio.post(ApiPath().diskPath, data: {'folder_path': path});
    return DiskPathEntity().fromJson(resp.data);
  }
}
