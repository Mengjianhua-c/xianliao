
import 'package:xianliao/models/topic/topics_list_entity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xianliao/env.dart';

import '../bloc_base.dart';

class TopicItemBloc implements BlocBase {
  BehaviorSubject<TopicsListDataTopic> _topic;

  Stream<TopicsListDataTopic> get topicItemStream {
    return _topic.stream;
  }

  TopicItemBloc(TopicsListDataTopic topic) {
    _topic = BehaviorSubject();
    if (topic != null) {
      _topic.add(topic);
    }
  }

  void realDispose() {
    _topic.close();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

class TopicsBloc extends BlocBase {
  final BehaviorSubject<TopicsListEntity> _topics = BehaviorSubject();
  var _currentStart = 1;
  final int _pn = 15;
  var _displayedIndexes = List<int>();
  bool _isLoadingMore = false;

  Observable<TopicsListEntity> get topicsSteam => _topics.stream;

  TopicsBloc() {
    print('init topic bloc');
    _getMovies();
  }

  _getMovies() {
    Env.apiClient.getTopicsList(_currentStart).then((topicsList) {
      // print("........ ${topicsList.toString()}");
      var newTopicsList = topicsList;
      if (_topics.value != null) {
        newTopicsList.data.topics =
        _topics.value.data.topics..addAll(topicsList.data.topics);
      }
      _topics.add(newTopicsList);
      _currentStart++;
      _isLoadingMore = false;
    });
  }

  refreshList(){
    _topics.value.data.topics = [];
    _currentStart = 1;
    _getMovies();
  }

  displayingItemOfPage(int page){
    print('index: $page');
    // log("index: $page", time: DateTime.now());
    _getMovies();
  }
  // displayingItemOfPage(int page){
  //   log("index: $page", time: DateTime.now());
  //   if (!_displayedIndexes.contains(page)){
  //     _displayedIndexes.add(page);
  //     if (page == _currentStart-1){
  //       _isLoadingMore = true;
  //       _getMovies();
  //     }
  //   }
  // }


  @override
  void dispose() {
    _topics.close();
  }
}
