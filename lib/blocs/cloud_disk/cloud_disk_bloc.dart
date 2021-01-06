import 'package:xianliao/env.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc_base.dart';
import 'package:xianliao/models/cloud_disk/disk_path_entity.dart';
import 'package:xianliao/services/cache/local_storage.dart';

class DiskPathBloc extends BlocBase {
  BehaviorSubject<DiskPathEntity> _diskPath = BehaviorSubject();

  Observable<DiskPathEntity> get getDiskPath => _diskPath.stream;

  DiskPathBloc() {
    LocalPath().initPath();
    _getDiskPath();
  }

  _getDiskPath() async {
    final path = await LocalPath().getPath();
    Env.apiClient.getDiskPath(path).then((value) {
      if (value.data != null) {
        _diskPath.add(value);
      }
    });
  }

  @override
  void dispose() {
    _diskPath.close();
  }
}
