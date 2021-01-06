import 'package:xianliao/blocs/topics/topics_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:xianliao/blocs/bloc_provider.dart';
import '../../models/topic/topics_list_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicsListPage extends StatefulWidget {
  @override
  _TopicsListPageState createState() => _TopicsListPageState();
}

class _TopicsListPageState extends State<TopicsListPage> {
  Set<TopicItemBloc> itemTopic = Set();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TopicsBloc>(context);


    return StreamBuilder<TopicsListEntity>(
      stream: bloc.topicsSteam,
      builder: (context, snapshot) {
        if (snapshot.data == null || snapshot.data.data.topics.length == 0) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        };
        var topicsEnvelop = snapshot.data.data;
        var topics = snapshot.data.data.topics;

        void _onRefresh() async {
          print('refresh now');
          await bloc.refreshList();
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
        }

        void _onLoading() async {
          // monitor network fetch
          print('load now');
          if (topicsEnvelop.topics.length >= topicsEnvelop.total) {
            _refreshController.loadNoData();
          } else {
            bloc.displayingItemOfPage(15 ~/ 15 + 1);
            _refreshController.loadComplete();
          }
        }
        return SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          header: ClassicHeader(),
          footer: CustomFooter(
            builder: (BuildContext context,LoadStatus mode){
              Widget body ;
              if(mode==LoadStatus.idle){
                body =  Text("上拉加载");
              }
              else if(mode==LoadStatus.loading){
                body =  CupertinoActivityIndicator();
              }
              else if(mode == LoadStatus.failed){
                body = Text("加载失败！点击重试！");
              }
              else if(mode == LoadStatus.canLoading){
                body = Text("松手,加载更多!");
              }
              else{
                body = Text("没有更多数据了!");
              }
              return Container(
                height: 55.0,
                child: Center(child:body),
              );
            },
          ),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.separated(
              itemBuilder: (context, index) {
                // if (index == topics.length - 1) {
                //   if (topicsEnvelop.topics.length >= topicsEnvelop.total) {
                //     return Center(
                //       child: Text('没有更多了···'),
                //     );
                //   } else {
                //     bloc.displayingItemOfPage(index ~/ 15 + 1);
                //     return Center(
                //       child: CupertinoActivityIndicator(),
                //     );
                //   }
                // }
                final topicBloc = TopicItemBloc(topics[index]);
                itemTopic.add(topicBloc);
                return BlocProvider(
                    child: TopicItemTilePage(), bloc: topicBloc);
              },
              separatorBuilder: (context, index) => Divider(
                    height: .5,
                    indent: 10,
                    endIndent: 10,
                    color: Color(0xFFDDDDDD),
                  ),
              itemCount: topics.length),
        );
      },
    );
  }

  @override
  void dispose() {
    itemTopic.forEach((bloc) => bloc.realDispose());
    super.dispose();
  }
}

class TopicProvider extends StatefulWidget {
  @override
  _TopicProviderState createState() => _TopicProviderState();
}

class _TopicProviderState extends State<TopicProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(child: TopicsListPage(), bloc: TopicsBloc());
  }
}

class TopicItemTilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TopicItemBloc>(context);
    return StreamBuilder<TopicsListDataTopic>(
      builder: (context, snapshot) {
        final topic = snapshot.data;
        if (topic == null) {
          return ListTile();
        }
        return InkWell(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  topic.title == null ? "" : topic.title,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      topic.name,
                      style: TextStyle(color: Colors.black38, fontSize: 14),
                    ),
                    Text(
                      topic.ctime,
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.black38, fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/topic/detail',
                arguments: {"id": topic.id});
          },
          hoverColor: Colors.white60,
        );
      },
      stream: bloc.topicItemStream,
    );
  }
}
