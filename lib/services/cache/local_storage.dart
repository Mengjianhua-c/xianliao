import '../cache/storage_util.dart';

class AuthInfo {
  final String _authKey = 'Authorization';

  saveInfo(String auth) {
    StorageUtil.setStringItem(this._authKey, auth);
  }

  getInfo() async {
    return await StorageUtil.getStringItem(this._authKey);
  }
}

class LocalPath {
  final String _path = 'path';

  appendPath(String path) {
    var oldPath = this.getPath();
    StorageUtil.setStringItem(_path, oldPath + path);
  }

  initPath() {
    StorageUtil.setStringItem(_path, '/');
  }

  getPath() async {
    var path = await StorageUtil.getStringItem(this._path);
    return path != null ? path : '/';
  }
}
