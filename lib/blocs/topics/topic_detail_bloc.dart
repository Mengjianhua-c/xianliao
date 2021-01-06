import 'package:xianliao/blocs/bloc_base.dart';
import 'package:xianliao/models/topic/topic_detail_entity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xianliao/env.dart';

class TopicDetailBloc extends BlocBase {
  BehaviorSubject<TopicDetailData> _topicDetail = BehaviorSubject();
  var listTopicDetail = Map<int, TopicDetailData>();

  get topicDetailStream => _topicDetail.stream;
  int _topicId;

  TopicDetailBloc(int _id) {
    print("blocpid: $_id");
    _getDetail(_id);
  }

  refreshCache(TopicDetailData _new) {
    var oldData = listTopicDetail[_topicId];
    if (oldData != null) {
      if (oldData != _new) {
        listTopicDetail[_topicId] = _new;
        print('refresh cache success id:$_topicId');
      }
    }
  }

  _getDetail(int _id) {
    var cacheDetail = listTopicDetail[_id];
    print('cache $cacheDetail');
    if (cacheDetail == null) {
      Env.apiClient.getTopicDetail(_id).then((topicDetailEn) {
        if (topicDetailEn != null) {
          _topicDetail.add(topicDetailEn.data);
          listTopicDetail[_id] = topicDetailEn.data;
        }
      });
    } else {
      print('use cache id: $_id');
      _topicDetail.add(cacheDetail);
    }
    _topicId = _id;
  }

  @override
  void dispose() {
    _topicDetail.close();
  }
}
