import 'package:xianliao/pages/cloud_disk/disk_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'topics.dart';
import '../home.dart';
import '../user/home.dart';

class TabConfig {
  final _tabs = [
    [
      '灌水区',
      TopicProvider(),
      Icon(Icons.topic),
      AppBar(title: Text('')),
    ],
    [
      '文件',
      DiskPathProvider(),
      Icon(Icons.cloud_rounded),
      AppBar(
        title: Container(
          height: 40,
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: OutlineButton(
                    child: Icon(Icons.search),
                    onPressed: () {},
                    shape: StadiumBorder(),

                  )),
              Expanded(child: Icon(Icons.share_rounded))
            ],
          ),
        ),
        backgroundColor: Color(0xfff4f4f4),
        toolbarOpacity: 0.5,
      )
    ],
    [
      '我的',
      HomeUserProvider(),
      Icon(Icons.home),
      AppBar(title: Text('')),
    ],
  ];

  tabTitle() {
    return _tabs.map((e) => e[0]).toList();
  }

  tabWidget() {
    return _tabs.map((e) => e[1]).toList();
  }

  bottomBarItem() {
    return _tabs.map((e) {
      return BottomNavigationBarItem(icon: e[2], label: e[0]);
    }).toList();
  }

  appBarItem() {
    return _tabs.map((e) => e[3]).toList();
  }
}

class TabsPage extends StatefulWidget {
  final Map arguments;

  TabsPage({Key key, this.arguments}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState(arguments: arguments);
}

class _TabsPageState extends State<TabsPage> {
  final Map arguments;
  final tabConfig = TabConfig();
  int idx = 1;
  List tabPagesList = [TopicProvider(), DiskPathProvider(), HomeUserProvider()];

  _TabsPageState({this.arguments});

  @override
  void initState() {
    // TODO: implement initState

    if (this.arguments != null) {
      this.idx = this.arguments['id'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: tabConfig.appBarItem()[idx],
      body: tabConfig.tabWidget()[idx],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 16,
        currentIndex: idx,
        items: tabConfig.bottomBarItem(),
        onTap: (index) {
          setState(() {
            this.idx = index;
          });
        },
      ),
    );
  }
}
