import 'package:xianliao/blocs/bloc_base.dart';

import 'package:xianliao/models/user/user_info_entity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xianliao/services/cache/sql_util.dart';

class HomeUserBloc extends BlocBase {
  BehaviorSubject<UserInfoData> _userInfo = BehaviorSubject();

  get userInfoStream => _userInfo.stream;

  HomeUserBloc() {

    _getDetail();
  }

  _getDetail() {
    DbUtil.getUser().then((value){
      if (value!=null){
        print('get cache success $value');
        _userInfo.add(value);
      }else{
        print('get cache failed');
      }
    });
  }

  @override
  void dispose() {
    _userInfo.close();
  }
}
