
import 'package:xianliao/blocs/topics/topic_detail_bloc.dart';
import 'package:xianliao/models/topic/topic_detail_entity.dart';
import 'package:xianliao/services/cli.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xianliao/blocs/bloc_provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:xianliao/env.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:like_button/like_button.dart';

class TopicDetailPage extends StatefulWidget {
  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  List<Widget> tagsResult(TopicDetailData topic) {
    return topic.tags.map((val) {
      return Container(
        child: FlatButton(
          child: Text(val.tagName == null ? '' : val.tagName, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),),
          onPressed: () {},
          textColor: Color(0xFFFB7299),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Color(0xFFd4d4d4),

          height: 30,
          minWidth: 30,
        ),
        margin: EdgeInsets.only(left: 10, top: 5),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TopicDetailBloc>(context);
    return StreamBuilder<TopicDetailData>(
      builder: (context, snapshot) {
        final topicDetail = snapshot.data;

        Future<bool> onLikeButtonTapped(bool isLike) async {
          final result = await Env.apiClient.topicLike(topicDetail.topic.id);
          if(result.code == 0){
            BotToast.showText(text: "${result.message}");
            return !isLike;
          }else{
            return isLike;
          }
        }

        return Scaffold(
            backgroundColor: Color(0xfff4f4f4),
            appBar: AppBar(
              title: Text(''),
              backgroundColor: Colors.cyan,
            ),
            body: (() {
              if (topicDetail != null) {
                return Scrollbar(
                    child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            topicDetail.topic.title == null
                                ? ""
                                : topicDetail.topic.title,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                        Container(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(ApiPath()
                                      .avatarUrl(topicDetail.topic.userId)),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Container(
                                  child: ListView(
                                    children: [
                                      Text(
                                        topicDetail.topic.name,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFFB7299)),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "1 粉丝",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                ),
                                flex: 1,
                              ),
                              SizedBox(
                                width: 130,
                              ),
                              Expanded(
                                child: LikeButton(
                                    size: 40,
                                    circleColor: CircleColor(
                                        start: Color(0xff00ddff),
                                        end: Color(0xFFFB7299)),
                                    bubblesColor: BubblesColor(
                                      dotPrimaryColor: Color(0xFFFB7299),
                                      dotSecondaryColor: Color(0xFFFB7299),
                                    ),
                                    likeBuilder: (bool isLiked) {
                                      return Icon(
                                        Icons.thumb_up_alt,
                                        color: isLiked
                                            ? Color(0xFFFB7299)
                                            : Colors.grey,
                                        size: 26,
                                      );
                                    },
                                    likeCount: topicDetail.topic.like,
                                    countBuilder: (int count, bool isLiked, String text) {
                                      var color = isLiked ? Color(0xFFFB7299) : Colors.grey;
                                      Widget result;
                                      if (count == 0) {
                                        result = Text(
                                          "点赞",
                                          style: TextStyle(color: color),
                                        );
                                      } else
                                        result = Text(
                                          text,
                                          style: TextStyle(color: color),
                                        );
                                      return result;
                                    },
                                    onTap: onLikeButtonTapped),
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: .5,
                        ),
                        Row(
                          children: tagsResult(topicDetail),
                        ),
                        Html(
                          data: topicDetail.topic.content == null
                              ? ""
                              : topicDetail.topic.content,
                          style: {"span": Style(fontSize: FontSize.large)},
                        ),
                        Divider(
                          height: 0.5,
                        ),
                      ],
                    ),
                  ),
                ));
              } else {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            }()));
      },
      stream: bloc.topicDetailStream,
    );
  }
}

// ignore: must_be_immutable
class TopicDetailProvider extends StatefulWidget {
  int _topicId;
  final arguments;

  TopicDetailProvider({Key key, this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    _topicId = arguments['id'];
    print("id: $_topicId");
    final bloc = TopicDetailBloc(_topicId);
    return _TopicDetailProviderState(bloc: bloc);
  }
}

class _TopicDetailProviderState extends State<TopicDetailProvider> {
  final TopicDetailBloc bloc;

  _TopicDetailProviderState({this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(child: TopicDetailPage(), bloc: bloc);
  }
}
