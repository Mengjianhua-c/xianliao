import 'package:xianliao/models/user/user_info_entity.dart';
import 'package:xianliao/blocs/user/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:xianliao/blocs/bloc_provider.dart';
import 'package:flutter_html/style.dart';
import '../widgets/text.dart';
import 'dart:io';
import 'package:xianliao/services/cli.dart';
import 'package:xianliao/services/cache/sql_util.dart';

class HomeUserPage extends StatefulWidget {
  @override
  _HomeUserPageState createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeUserBloc>(context);
    return StreamBuilder<UserInfoData>(
      stream: bloc.userInfoStream,
      builder: (context, snapshot) {
        UserInfoData userInfo = UserInfoData();
        if (snapshot.data != null) {
          userInfo = snapshot.data;
          return Container(
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: MyText(userInfo.name),
                  accountEmail: Row(
                    children: [
                      Expanded(
                        child: MyText(userInfo.email),
                        flex: 2,
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 5),
                          child: OutlineButton(
                            color: Color(0xff66ffee),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.redAccent,
                                ),
                                Text('退出', style:TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w700),)
                              ],
                            ),
                            onPressed: () {
                              DbUtil.delUser(userInfo.uid).then((value) {
                                userInfo = null;
                                Navigator.pushReplacementNamed(context, '/',
                                    arguments: {'id': 1});
                              });
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          height: 35,
                          width: 60,

                        ),
                        flex: 1,
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      image: DecorationImage(
                          image: AssetImage('resource/images/userBg.jpg'),
                          fit: BoxFit.cover)),
                  currentAccountPicture: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/space');
                    },
                    icon: Container(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(ApiPath().avatarUrl(userInfo.uid)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/user/login');
                    },
                    child: Text('点击登录'),
                  ),
                  accountEmail: MyText(''),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('resource/images/userBg.jpg'),
                          fit: BoxFit.cover)),
                  currentAccountPicture: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/space');
                    },
                    icon: Container(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                          backgroundImage:
                              AssetImage('resource/images/user.jpg')),
                    ),
                  ),
                )
              ],
            ),
          );
          ;
        }
      },
    );
  }
}

class HomeUserProvider extends StatefulWidget {
  @override
  _HomeUserProviderState createState() => _HomeUserProviderState();
}

class _HomeUserProviderState extends State<HomeUserProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(child: HomeUserPage(), bloc: HomeUserBloc());
  }
}
