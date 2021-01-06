import 'dart:convert';

import 'package:xianliao/models/actor.dart';
import 'package:xianliao/models/movie.dart';
import 'package:xianliao/models/topic/topic_detail_entity.dart';
import 'package:xianliao/models/topic/topics_list_entity.dart';
import 'package:xianliao/models/user/login_entity.dart';
import 'package:xianliao/models/user/user_info_entity.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'cli.dart';

createMockMovieWithTitle(String title, String id) {
  return Movie(
      id: id,
      title: title,
      rating: "9.3",
      director: "张三丰",
      year: "1999",
      poster:
          "https://img3.doubanio.com/view/photo/m_ratio_poster/public/p480747492.webp",
      summary:
          "20世纪40年代末，小有成就的青年银行家安迪（蒂姆·罗宾斯 Tim Robbins 饰）因涉嫌杀害妻子及她的情人而锒铛入狱。在这座名为肖申克的监狱内，希望似乎虚无缥缈，终身监禁的惩罚无疑注定了安迪接下来灰暗绝望的人生。未过多久，安迪尝试接近囚犯中颇有声望的瑞德（摩根·弗里曼 Morgan Freeman 饰），请求对方帮自己搞来小锤子。以此为契机，二人逐渐熟稔，安迪也仿佛在鱼龙混杂、罪恶横生、黑白混淆的牢狱中找到属于自己的求生之道。他利用自身的专业知识，帮助监狱管理层逃税、洗黑钱，同时凭借与瑞德的交往在犯人中间也渐渐受到礼遇。表面看来，他已如瑞德那样对那堵高墙从憎恨转变为处之泰然，但是对自由的渴望仍促使他朝着心中的希望和目标前进。而关于其罪行的真相，似乎更使这一切朝前推进了一步…… ",
      actors: <Actor>[
        Actor(
            name: '蒂姆·罗宾斯',
            avatar:
                'https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p17525.webp'),
        Actor(
            name: '摩根·弗里曼',
            avatar:
                'https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p34642.webp'),
        Actor(
            name: '鲍勃·冈顿',
            avatar:
                'https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p5837.webp'),
      ]);
}

class MockAPI{

  @override
  Future<Movie> getMovie(String movieID) {
    return Future.value(createMockMovieWithTitle('我是电影 ${movieID}', movieID));
  }

  @override
  Future<MovieEnvelope> getMovieList(int start) {
    var movies = List<Movie>();
    for (int i = 0; i < 20; i++) {
      movies.add(createMockMovieWithTitle('我是标题 $i', i.toString()));
    }
    final movieEnvelope =
        MovieEnvelope(count: 20, start: start, total: 250, movies: movies);
    return Future.delayed(Duration(seconds: 1), () => movieEnvelope);
  }

  Future<TopicsListEntity> getTopicsList(int page) async {

    var response = await dio.get(ApiPath().topicList,
        queryParameters: {"page": page, "pn": 15, "type": "all"});
    print(response.data["message"]);

    return TopicsListEntity().fromJson(response.data);
  }

  Future<TopicDetailEntity> getTopicDetail(int id) async {
    var response = await dio.post(ApiPath().topicDetail, data: {"id":id});
    return TopicDetailEntity().fromJson(response.data);
  }

  @override
  Future<UserInfoEntity> getUserInfo() {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }

  @override
  Future<LoginEntity> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
