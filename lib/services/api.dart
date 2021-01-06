import 'package:xianliao/models/cloud_disk/disk_path_entity.dart';
import 'package:xianliao/models/movie.dart';
import 'package:xianliao/models/topic/topic_detail_entity.dart';
import 'package:xianliao/models/topic/topics_list_entity.dart';
import 'package:xianliao/models/user/login_entity.dart';
import 'package:xianliao/models/user/user_info_entity.dart';
import 'package:xianliao/models/cli_base_entity.dart';

// 抽象出这个类是为了方便测试
abstract class API {
  Future<MovieEnvelope> getMovieList(int start);
  Future<Movie> getMovie(String movieID);
  Future<TopicsListEntity> getTopicsList(int page);
  Future<TopicDetailEntity> getTopicDetail(int id);
  Future<LoginEntity> login(String username, String password);
  Future<UserInfoEntity> getUserInfo();
  Future<CliBaseEntity> topicLike(int topicId);
  Future<DiskPathEntity> getDiskPath(String path);
}
